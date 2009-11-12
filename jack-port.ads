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

  -- proc_map : jack_port_connected
  function Connected (Port : in Client.Port_t) return Boolean;

  -- proc_map : jack_port_connected_to
  function Connected_To
    (Port      : in Client.Port_t;
     Port_Name : in Client.Port_Name_t) return Boolean;

  -- proc_map : jack_port_flags
  function Flags
    (Port : in Client.Port_t) return Client.Port_Flags_t;

  -- proc_map : jack_port_type
  function Get_Type
    (Port : in Client.Port_t) return Client.Port_Type_t;

  -- proc_map : jack_port_name
  function Name
    (Port : in Client.Port_t) return Client.Port_Name_t;

  -- proc_map : jack_port_short_name
  function Short_Name
    (Port : in Client.Port_t) return Client.Port_Name_t;

end Jack.Port;
