with C_String;
with Jack.Thin;

package body Jack.Port is

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
