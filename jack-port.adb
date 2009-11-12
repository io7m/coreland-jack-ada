with C_String;
with Interfaces.C;
with Jack.Thin;

package body Jack.Port is
  package C renames Interfaces.C;

  use type C.int;

  --
  -- Buffer_Address
  --

  function Buffer_Address
    (Port             : in Client.Port_t;
     Number_Of_Frames : in Client.Number_Of_Frames_t) return System.Address is
  begin
    return Thin.Port_Get_Buffer
      (Port             => Client.To_Address (Port),
       Number_Of_Frames => Thin.Number_Of_Frames_t (Number_Of_Frames));
  end Buffer_Address;

  --
  -- Connected
  --

  function Connected (Port : in Client.Port_t) return Boolean is
  begin
    return 1 = Thin.Port_Connected (Client.To_Address (Port));
  end Connected;

  --
  -- Connected_To
  --

  function Connected_To
    (Port      : in Client.Port_t;
     Port_Name : in Client.Port_Name_t) return Boolean
  is
    C_Name : aliased C.char_array := C.To_C (Client.Port_Names.To_String (Port_Name));
  begin
    return 1 = Thin.Port_Connected_To
      (Port      => Client.To_Address (Port),
       Port_Name => C_String.To_C_String (C_Name'Unchecked_Access));
  end Connected_To;

  --
  -- Flags
  --

  function Flags
    (Port : in Client.Port_t) return Client.Port_Flags_t is
  begin
    return Client.Map_Thin_To_Port_Flags
      (C.unsigned_long (Thin.Port_Flags (Client.To_Address (Port))));
  end Flags;

  --
  -- Get_Type
  --

  function Get_Type
    (Port : in Client.Port_t) return Client.Port_Type_t is
  begin
    return Client.To_Port_Type
      (C_String.To_String (Thin.Port_Type (Client.To_Address (Port))));
  end Get_Type;

  --
  -- Name
  --

  function Name
    (Port : in Client.Port_t) return Client.Port_Name_t is
  begin
    return Client.To_Port_Name
      (C_String.To_String (Thin.Port_Name (Client.To_Address (Port))));
  end Name;

  --
  -- Short_Name
  --

  function Short_Name
    (Port : in Client.Port_t) return Client.Port_Name_t is
  begin
    return Client.To_Port_Name
      (C_String.To_String (Thin.Port_Short_Name (Client.To_Address (Port))));
  end Short_Name;

end Jack.Port;
