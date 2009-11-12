with C_String;
with Interfaces.C;
with Jack.Thin;

package body Jack.Port is
  package C renames Interfaces.C;

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
  -- Flags
  --

  function Flags
    (Port : in Client.Port_t) return Client.Port_Flags_t is
  begin
    return Client.Map_Thin_To_Port_Flags
      (C.unsigned_long (Thin.Port_Flags (Client.To_Address (Port))));
  end Flags;

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
