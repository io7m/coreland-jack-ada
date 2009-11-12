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
    (Port             : in Jack.Client.Port_t;
     Number_Of_Frames : in Jack.Client.Number_Of_Frames_t) return System.Address is
  begin
    return Jack.Thin.Port_Get_Buffer
      (Port             => Jack.Client.To_Address (Port),
       Number_Of_Frames => Jack.Thin.Number_Of_Frames_t (Number_Of_Frames));
  end Buffer_Address;

  --
  -- Connected
  --

  function Connected (Port : in Jack.Client.Port_t) return Boolean is
  begin
    return 1 = Jack.Thin.Port_Connected (Jack.Client.To_Address (Port));
  end Connected;

  --
  -- Connected_To
  --

  function Connected_To
    (Port      : in Jack.Client.Port_t;
     Port_Name : in Jack.Client.Port_Name_t) return Boolean
  is
    C_Name : aliased C.char_array := C.To_C (Jack.Client.Port_Names.To_String (Port_Name));
  begin
    return 1 = Jack.Thin.Port_Connected_To
      (Port      => Jack.Client.To_Address (Port),
       Port_Name => C_String.To_C_String (C_Name'Unchecked_Access));
  end Connected_To;

  --
  -- Flags
  --

  function Flags
    (Port : in Jack.Client.Port_t) return Jack.Client.Port_Flags_t is
  begin
    return Jack.Client.Map_Thin_To_Port_Flags
      (C.unsigned_long (Jack.Thin.Port_Flags (Jack.Client.To_Address (Port))));
  end Flags;

  --
  -- Get_Type
  --

  function Get_Type
    (Port : in Jack.Client.Port_t) return Jack.Client.Port_Type_t is
  begin
    return Jack.Client.To_Port_Type
      (C_String.To_String (Jack.Thin.Port_Type (Jack.Client.To_Address (Port))));
  end Get_Type;

  --
  -- Latency
  --

  function Latency
    (Port : in Jack.Client.Port_t) return Jack.Client.Number_Of_Frames_t is
  begin
    return Jack.Client.Number_Of_Frames_t
      (Jack.Thin.Port_Get_Latency (Jack.Client.To_Address (Port)));
  end Latency;

  --
  -- Name
  --

  function Name
    (Port : in Jack.Client.Port_t) return Jack.Client.Port_Name_t is
  begin
    return Jack.Client.To_Port_Name
      (C_String.To_String (Jack.Thin.Port_Name (Jack.Client.To_Address (Port))));
  end Name;

  --
  -- Set_Alias
  --

  procedure Set_Alias
    (Port       : in     Jack.Client.Port_t;
     Port_Alias : in     Jack.Client.Port_Name_t;
     Failed     :    out Boolean)
  is
    C_Alias : aliased C.char_array := C.To_C (Jack.Client.Port_Names.To_String (Port_Alias));
  begin
    Failed := 0 = Jack.Thin.Port_Set_Alias
      (Port  => Jack.Client.To_Address (Port),
       Alias => C_String.To_C_String (C_Alias'Unchecked_Access));
  end Set_Alias;

  --
  -- Set_Latency
  --

  procedure Set_Latency
    (Port    : in Jack.Client.Port_t;
     Latency : in Jack.Client.Number_Of_Frames_t) is
  begin
    Jack.Thin.Port_Set_Latency
      (Port             => Jack.Client.To_Address (Port),
       Number_Of_Frames => Jack.Thin.Number_Of_Frames_t (Latency));
  end Set_Latency;

  --
  -- Set_Name
  --

  procedure Set_Name
    (Port      : in     Jack.Client.Port_t;
     Port_Name : in     Jack.Client.Port_Name_t;
     Failed    :    out Boolean)
  is
    C_Name : aliased C.char_array := C.To_C (Jack.Client.Port_Names.To_String (Port_Name));
  begin
    Failed := 0 = Jack.Thin.Port_Set_Name
      (Port      => Jack.Client.To_Address (Port),
       Port_Name => C_String.To_C_String (C_Name'Unchecked_Access));
  end Set_Name;

  --
  -- Short_Name
  --

  function Short_Name
    (Port : in Jack.Client.Port_t) return Jack.Client.Port_Name_t is
  begin
    return Jack.Client.To_Port_Name
      (C_String.To_String (Jack.Thin.Port_Short_Name
        (Jack.Client.To_Address (Port))));
  end Short_Name;

end Jack.Port;
