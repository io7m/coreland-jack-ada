with Ada.Containers.Ordered_Sets;
with Ada.Strings.Bounded;
with Ada.Strings;
with Ada.Unchecked_Deallocation;
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

  function Compare
    (Left  : in Client_t;
     Right : in Client_t) return Boolean;

  function "="
    (Left  : in Client_t;
     Right : in Client_t) return Boolean renames Compare;

  --
  -- Port
  --

  type Port_t is limited private;

  Invalid_Port : constant Port_t;

  function Compare
    (Left  : in Port_t;
     Right : in Port_t) return Boolean;

  function "="
    (Left  : in Port_t;
     Right : in Port_t) return Boolean renames Compare;

  --
  -- Port name
  --

  subtype Port_Name_Size_t  is Natural          range 0 .. Natural (Thin.Port_Name_Size);
  subtype Port_Name_Index_t is Port_Name_Size_t range 1 .. Port_Name_Size_t'Last;

  package Port_Names is new
    Ada.Strings.Bounded.Generic_Bounded_Length (Port_Name_Index_t'Last);

  function To_Port_Name
    (Input : in String;
     Drop  : in Ada.Strings.Truncation := Ada.Strings.Error)
    return Port_Names.Bounded_String renames Port_Names.To_Bounded_String;

  subtype Port_Name_t is Port_Names.Bounded_String;

  package Port_Name_Sets is new Ada.Containers.Ordered_Sets
    (Element_Type => Port_Name_t,
     "="          => Port_Names."=",
     "<"          => Port_Names."<");

  subtype Port_Name_Set_t is Port_Name_Sets.Set;

  --
  -- Port type
  --

  subtype Port_Type_Size_t  is Natural          range 0 .. Natural (Thin.Port_Type_Size);
  subtype Port_Type_Index_t is Port_Type_Size_t range 1 .. Port_Type_Size_t'Last;

  package Port_Types is new
    Ada.Strings.Bounded.Generic_Bounded_Length (Port_Type_Index_t'Last);

  function To_Port_Type
    (Input : in String;
     Drop  : in Ada.Strings.Truncation := Ada.Strings.Error)
    return Port_Types.Bounded_String renames Port_Types.To_Bounded_String;

  subtype Port_Type_t is Port_Types.Bounded_String;

  package Port_Type_Sets is new Ada.Containers.Ordered_Sets
    (Element_Type => Port_Type_t,
     "="          => Port_Types."=",
     "<"          => Port_Types."<");

  subtype Port_Type_Set_t is Port_Type_Sets.Set;

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

  Default_Audio_Type : constant Port_Type_t := To_Port_Type ("32 bit float mono audio");

  -- proc_map : jack_port_register
  procedure Port_Register
    (Client      : in     Client_t;
     Port        :    out Port_t;
     Port_Name   : in     Port_Name_t;
     Port_Type   : in     Port_Type_t  := Default_Audio_Type;
     Port_Flags  : in     Port_Flags_t := (others => False);
     Buffer_Size : in     Natural      := 0);

  -- proc_map : jack_activate
  procedure Activate
    (Client : in     Client_t;
     Failed :    out Boolean);

  -- proc_map : jack_deactivate
  procedure Deactivate
    (Client : in     Client_t;
     Failed :    out Boolean);

  -- proc_map : jack_get_ports
  procedure Get_Ports
    (Client            : in     Client_t;
     Port_Name_Pattern : in     String           := "";
     Port_Type_Pattern : in     String           := "";
     Port_Flags        : in     Port_Flags_t     := (others => False);
     Ports             :    out Port_Name_Set_t);

  generic
    type User_Data_Type        is private;
    type User_Data_Access_Type is access User_Data_Type;

  package Generic_Callbacks is

    type Process_Callback_State_t is record
      Callback  : access procedure
        (Number_Of_Frames : in Number_Of_Frames_t;
         User_Data        : in User_Data_Access_Type);
      User_Data : User_Data_Access_Type;
    end record;

    type Process_Callback_State_Access_t is access Process_Callback_State_t;

    procedure Deallocate_State is new Ada.Unchecked_Deallocation
      (Object => User_Data_Type,
       Name   => User_Data_Access_Type);

    -- proc_map : jack_set_process_callback
    procedure Set_Process_Callback
      (Client    : in     Client_t;
       State     : in     Process_Callback_State_Access_t;
       Failed    :    out Boolean);

  end Generic_Callbacks;

  -- proc_map : jack_port_is_mine
  function Port_Is_Mine
    (Client : in Client_t;
     Port   : in Port_t) return Boolean;

  -- proc_map : jack_port_get_total_latency
  function Total_Latency
    (Client : in Client_t;
     Port   : in Port_t) return Number_Of_Frames_t;

  -- proc_map : jack_recompute_total_latency
  procedure Recompute_Total_Latency
    (Client : in     Client_t;
     Port   : in     Port_t;
     Failed :    out Boolean);

  -- proc_map : jack_recompute_total_latencies
  procedure Recompute_Total_Latencies
    (Client : in     Client_t;
     Failed :    out Boolean);

  --
  -- Private (but required by other modules)
  --

  function To_Address (Client : in Client_t) return System.Address;
  pragma Inline (To_Address);

  function To_Address (Port : in Port_t) return System.Address;
  pragma Inline (To_Address);

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

private

  type Client_t is new System.Address;
  type Port_t   is new System.Address;

  Invalid_Client : constant Client_t := Client_t (System.Null_Address);
  Invalid_Port   : constant Port_t   := Port_t (System.Null_Address);

end Jack.Client;
