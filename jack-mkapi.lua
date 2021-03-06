#!/usr/bin/env lua

local string_ex = require ("string_ex")
local io        = require ("io")
local os        = require ("os")

local argv      = arg
local argc      = table.maxn (argv)

if argc ~= 3 then
  io.stderr:write ("usage: api_types_map api_names_map types_map\n")
  os.exit (1)
end

assert (argc == 3)
local api_types_map = io.open (argv[1])
local api_names_map = io.open (argv[2])
local global_types_map  = io.open (argv[3])
assert (api_types_map)
assert (api_names_map)
assert (global_types_map)

local types_ada_kind = {}
local types_c_to_ada = {}
local types_ada_to_c = {}
local subprograms    = {}

--
-- Initialize types map for C -> Ada conversion
--

for line in global_types_map:lines() do
  local record = string_ex.split (line, ":")

  record[1] = record[1]:gsub ("[%s]*$", "")
  record[2] = record[2]:gsub ("[%s]*", "")
  record[3] = record[3]:gsub ("[%s]*", "")

  types_ada_kind [record [1]] = record[3] -- ada_type -> kind
  types_c_to_ada [record [1]] = record[2] -- c_type -> ada_type
  types_ada_to_c [record [2]] = record[1] -- ada_type -> c_type
end

--
-- Read API map
--

line = 1
while true do
  local type_line  = api_types_map:read ("*l")
  local name_line  = api_names_map:read ("*l")
  local subprogram = {}

  -- EOF
  if (not type_line) and (not name_line) then break end

  -- Sanity checking
  if not type_line then
    if name_line then error ("type map unexpected EOF at line "..line) end
  end
  if not name_line then
    if type_line then error ("name map unexpected EOF at line "..line) end
  end

  local type_record = string_ex.split (type_line, ":")
  local name_record = string_ex.split (name_line, ":")

  -- Strip whitespace
  for index, item in pairs (type_record) do
    type_record [index] = type_record [index]:gsub ("^[%s]*", "")
    type_record [index] = type_record [index]:gsub ("[%s]*$", "")
  end
  for index, item in pairs (name_record) do
    name_record [index] = name_record [index]:gsub ("^[%s]*", "")
    name_record [index] = name_record [index]:gsub ("[%s]*$", "")
  end

  -- Sanity checking on name
  if type_record [2] ~= name_record [1] then
    error ("name "..type_record [2].." does not match "..name_record [1].." at line "..line)
  end

  subprogram.name = type_record [2]

  -- Types of API entry
  if type_record [1] == "void" then
    subprogram.type = "procedure"
  else
    subprogram.type        = "function"
    subprogram.return_type = type_record [1]
  end

  table.remove (type_record, 1)
  table.remove (type_record, 1)
  table.remove (name_record, 1)

  -- Sanity checking on parameter list
  if #type_record ~= #name_record then
    if type_record [1] ~= "void" then
      print (type_record [1])
      error ("number of parameters in maps does not match for "..subprogram.name..", line "..line)
    end
  end

  -- Construct parameters
  subprogram.parameters = {}
  if type_record [1] ~= "void" then
    for index, type_name in pairs (type_record) do
      local parameter = {}
      parameter.name = name_record [index]
      parameter.type = type_record [index]

      table.insert (subprogram.parameters, parameter)
    end
  end

  table.insert (subprograms, subprogram)

  line = line + 1
end

--
-- Prefix uppercase character with underscore, if preceded by lowercase character.
-- Prefix numeric character with underscore.
--

local function modify_name (name)
  assert (type (name) == "string")
  local mod_name = name
  mod_name = mod_name:gsub ("([a-z])([A-Z])", "%1_%2")
  mod_name = mod_name:gsub ("[0-9]", "_%1")
  return mod_name
end

--
-- Map C types to Ada types.
--

local function map_type_to_ada (name)
  assert (type (name) == "string")
  assert (types_c_to_ada [name], "no type for "..name)
  return types_c_to_ada [name]
end

--
-- Get subprogram name
--

local function subprogram_name (subprogram)
  assert (type (subprogram) == "table")

  -- Modify name for Ada
  local sub_name = subprogram.name
  sub_name = modify_name (sub_name)

  -- Hack
  if (sub_name == "Begin") or
     (sub_name == "End") then
    sub_name = "GL_"..sub_name
  end

  return sub_name
end

--
-- Check if a type can be replaced with an address type.
--

local function can_be_address (input_type)
  assert (type (input_type) == "string")
  return (types_ada_kind [input_type] == "access") or
         (types_ada_kind [input_type] == "access_constant")
end

--
-- Check to see if one of the subprograms parameters (if any) or
-- return type (if any) is an access type.
--

local function want_raw_addressing (subprogram)
  assert (type (subprogram) == "table")

  if subprogram.type == "function" then
    if can_be_address (subprogram.return_type) then
      return true
    end
  end

  if #subprogram.parameters <= 0 then
    return false
  end

  for index, parameter in pairs (subprogram.parameters) do
    if can_be_address (parameter.type) then
      return true
    end
  end

  return false
end

--
-- Write subprogram definition
--

local function write_subprogram (sub_name, subprogram, raw_addressing)
  assert (type (sub_name) == "string")
  assert (type (subprogram) == "table")
  assert (type (raw_addressing) == "boolean")

  -- Write initial name/type
  io.write ([[
  ]]..subprogram.type..[[ ]]..sub_name..[[
]])

  -- Write subprogram parameters
  if #subprogram.parameters > 0 then
    local longest_name = 0

    -- Check lengths of subprogram parameter names
    for index, parameter in pairs (subprogram.parameters) do
      if #parameter.name > longest_name then
        longest_name = #parameter.name
      end
    end

    -- Write subprogram parameters.
    for index, parameter in pairs (subprogram.parameters) do
      -- First parameter? Open parentheses.
      if index == 1 then
        io.write ("\n")
        io.write ("    (")
      else
        io.write ("     ")
      end

      io.write (parameter.name)

      -- Align colons
      for index = #parameter.name, longest_name do
        io.write (" ")
      end

      -- Want an 'untyped' version using raw memory addresses for access types?
      local use_addr = false
      if can_be_address (parameter.type) then
        use_addr = true
      end
      if use_addr then
        io.write (": in System.Address")
      else
        io.write (": "..map_type_to_ada (parameter.type))
      end

      if not (index == table.maxn (subprogram.parameters)) then
        io.write (";\n")
      end
    end

    -- Close
    io.write (")")
  end

  -- Function type? Write return type, else close procedure.
  if subprogram.type == "function" then
    local use_addr = false
    if raw_addressing then
      if can_be_address (subprogram.return_type) then
        use_addr = true
      end
    end

    if use_addr then
      io.write (" return System.Address")
    else
      io.write (" return "..map_type_to_ada (subprogram.return_type))
    end
  end

  io.write (";\n")
  io.write ([[
  pragma Import (C, ]]..sub_name..[[, "jack_]]..subprogram.name:lower()..[[");

]])
end

--
-- Generate API
--

for index, subprogram in pairs (subprograms) do
  local sub_name = subprogram_name (subprogram)

  -- Check that there's actually a parameter to change (otherwise the
  -- result is an identical, conflicting definition).
  write_subprogram (sub_name, subprogram, want_raw_addressing (subprogram))
end
