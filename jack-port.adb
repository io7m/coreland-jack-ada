with C_String;
with Jack.Thin;

package body Jack.Port is

  --
  -- Get_Buffer_Address
  --

  function Get_Buffer_Address
    (Port             : in Client.Port_t;
     Number_Of_Frames : in Client.Number_Of_Frames_t) return System.Address is
  begin
    return Thin.Port_Get_Buffer
      (Port             => Client.To_Address (Port),
       Number_Of_Frames => Thin.Number_Of_Frames_t (Number_Of_Frames));
  end Get_Buffer_Address;

  --
  -- Name
  --

  -- proc_map : jack_port_name
  function Name
    (Port : in Client.Port_t) return Client.Port_Name_t is
  begin
    return Client.To_Port_Name
      (C_String.To_String (Thin.Port_Name (Client.To_Address (Port))));
  end Name;

end Jack.Port;
