with Jack.Client;
with System;

package Jack.Port is

  --
  -- API
  --

  -- proc_map : jack_port_get_buffer
  function Get_Buffer_Address
    (Port             : in Client.Port_t;
     Number_Of_Frames : in Client.Number_Of_Frames_t) return System.Address;

end Jack.Port;
