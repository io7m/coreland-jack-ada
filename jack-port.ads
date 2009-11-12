with Jack.Client;
with System;

package Jack.Port is

  --
  -- API
  --

  -- proc_map : jack_port_get_buffer
  function Buffer_Address
    (Port             : in Jack.Client.Port_t;
     Number_Of_Frames : in Jack.Client.Number_Of_Frames_t) return System.Address;

  -- proc_map : jack_port_connected
  function Connected (Port : in Jack.Client.Port_t) return Boolean;

  -- proc_map : jack_port_connected_to
  function Connected_To
    (Port      : in Jack.Client.Port_t;
     Port_Name : in Jack.Client.Port_Name_t) return Boolean;

  -- proc_map : jack_port_flags
  function Flags
    (Port : in Jack.Client.Port_t) return Jack.Client.Port_Flags_t;

  -- proc_map : jack_port_type
  function Get_Type
    (Port : in Jack.Client.Port_t) return Jack.Client.Port_Type_t;

  -- proc_map : jack_port_get_latency
  function Latency
    (Port : in Jack.Client.Port_t) return Jack.Client.Number_Of_Frames_t;

  -- proc_map : jack_port_name
  function Name
    (Port : in Jack.Client.Port_t) return Jack.Client.Port_Name_t;

  -- proc_map : jack_port_set_latency
  procedure Set_Latency
    (Port    : in Jack.Client.Port_t;
     Latency : in Jack.Client.Number_Of_Frames_t);

  -- proc_map : jack_port_short_name
  function Short_Name
    (Port : in Jack.Client.Port_t) return Jack.Client.Port_Name_t;

end Jack.Port;
