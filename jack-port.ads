with Jack.Client;
with System;

package Jack.Port is

  --
  -- API
  --

  -- proc_map : jack_port_get_buffer
  function Buffer_Address
    (Port             : in Client.Port_t;
     Number_Of_Frames : in Client.Number_Of_Frames_t) return System.Address;

  -- proc_map : jack_port_name
  function Name
    (Port : in Client.Port_t) return Client.Port_Name_t;

  -- proc_map : jack_port_short_name
  function Short_Name
    (Port : in Client.Port_t) return Client.Port_Name_t;

end Jack.Port;
