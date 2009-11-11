with Ada.Containers.Ordered_Sets;
with Ada.Strings.Bounded;
with Jack.Thin;
with System;

pragma Elaborate_All (Jack.Thin);

package Jack.Client is

  --
  -- Types.
  --

  type Number_Of_Frames_t is new Thin.Number_Of_Frames_t;

  --
  -- Options
  --

  type Option_Selector_t is
    (Do_Not_Start_Server,
     Use_Exact_Name,
     Server_Name,
     Load_Name,
     Load_Initialize);

  type Options_t is array (Option_Selector_t) of Boolean;

  --
  -- Status
  --

  type Status_Selector_t is
    (Failure,
     Invalid_Option,
     Name_Not_Unique,
     Server_Started,
     Server_Failed,
     Server_Error,
     No_Such_Client,
     Load_Failure,
     Init_Failure,
     Shared_Memory_Failure,
     Version_Error);

  type Status_t is array (Status_Selector_t) of Boolean;

  --
  -- Port flags
  --

  type Port_Flag_Selector_t is
    (Port_Is_Input,
     Port_Is_Output,
     Port_Is_Physical,
     Port_Can_Monitor,
     Port_Is_Terminal);

  type Port_Flags_t is array (Port_Flag_Selector_t) of Boolean;

  --
  -- Client
  --

  type Client_t is limited private;

  Invalid_Client : constant Client_t;

  --
  -- Port
  --

  type Port_t is limited private;

  Invalid_Port : constant Port_t;

  --
  -- Port name
  --

  function Port_Name_Size return Natural;
  pragma Inline (Port_Name_Size);

  subtype Port_Name_Size_t  is Natural          range 0 .. Port_Name_Size;
  subtype Port_Name_Index_t is Port_Name_Size_t range 1 .. Port_Name_Size_t'Last;

  package Port_Names is new
    Ada.Strings.Bounded.Generic_Bounded_Length (Port_Name_Index_t'Last);

  subtype Port_Name_t is Port_Names.Bounded_String;

  package Port_Name_Sets is new Ada.Containers.Ordered_Sets
    (Element_Type => Port_Name_t,
     "="          => Port_Names."=",
     "<"          => Port_Names."<");

  subtype Port_Name_Set_t is Port_Name_Sets.Set;

  --
  -- API
  --

  -- proc_map : jack_client_close
  procedure Close
    (Client : in     Client_t;
     Failed :    out Boolean);

  -- proc_map : jack_connect
  procedure Connect
    (Client           : in     Client_t;
     Source_Port      : in     Port_Name_t;
     Destination_Port : in     Port_Name_t;
     Failed           :    out Boolean);

  -- proc_map : jack_disconnect
  procedure Disconnect
    (Client           : in     Client_t;
     Source_Port      : in     Port_Name_t;
     Destination_Port : in     Port_Name_t;
     Failed           :    out Boolean);

  -- proc_map : jack_client_open
  procedure Open
    (Client_Name : in     String;
     Options     : in     Options_t;
     Client      :    out Client_t;
     Status      : in out Status_t);

  -- proc_map : jack_port_register
  procedure Port_Register
    (Client      : in     Client_t;
     Port        :    out Port_t;
     Port_Name   : in     Port_Name_t;
     Port_Type   : in     String;
     Port_Flags  : in     Port_Flags_t;
     Buffer_Size : in     Natural := 0);

  -- proc_map : jack_activate
  procedure Activate
    (Client : in     Client_t;
     Failed :    out Boolean);

  -- proc_map : jack_get_ports
  procedure Get_Ports
    (Client            : in     Client_t;
     Port_Name_Pattern : in     String;
     Port_Type_Pattern : in     String;
     Port_Flags        : in     Port_Flags_t;
     Ports             :    out Port_Name_Set_t);

  generic
    type User_Data_Type is private;
    type User_Data_Access_Type is access User_Data_Type;

  package Generic_Callbacks is

    type Process_Callback_State_t is record
      Callback  : access procedure
        (Number_Of_Frames : in Number_Of_Frames_t;
         User_Data        : in User_Data_Access_Type);
      User_Data : User_Data_Access_Type;
    end record;

    type Process_Callback_State_Access_t is access Process_Callback_State_t;

    -- proc_map : jack_set_process_callback
    procedure Set_Process_Callback
      (Client    : in     Client_t;
       State     : in     Process_Callback_State_Access_t;
       Failed    :    out Boolean);

  end Generic_Callbacks;

private

  type Client_t is new System.Address;
  type Port_t   is new System.Address;

  Invalid_Client : constant Client_t := Client_t (System.Null_Address);
  Invalid_Port   : constant Port_t   := Port_t (System.Null_Address);

  function Map_Status_To_Thin (Status : Status_t) return Thin.Status_t;
  pragma Inline (Map_Status_To_Thin);

  function Map_Thin_To_Status (Status : Thin.Status_t) return Status_t;
  pragma Inline (Map_Thin_To_Status);

  function Map_Options_To_Thin (Options : Options_t) return Thin.Options_t;
  pragma Inline (Map_Options_To_Thin);

  function Map_Thin_To_Options (Options : Thin.Options_t) return Options_t;
  pragma Inline (Map_Thin_To_Options);

  function Map_Port_Flags_To_Thin (Port_Flags : Port_Flags_t) return Thin.Port_Flags_t;
  pragma Inline (Map_Port_Flags_To_Thin);

  function Map_Thin_To_Port_Flags (Port_Flags : Thin.Port_Flags_t) return Port_Flags_t;
  pragma Inline (Map_Thin_To_Port_Flags);

end Jack.Client;
