with Jack.Thin;
with Jack.Types;
with System;

generic
  with package Types is new Jack.Types (<>);

package Jack.Client is

  subtype Sample_Type_t is Types.Sample_Type_t;

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
  -- Client
  --

  type Client_t is limited private;

  Invalid_Client : constant Client_t;

  --
  -- API
  --

  -- proc_map : jack_client_open
  procedure Open
    (Client_Name : in     String;
     Options     : in     Options_t;
     Client      :    out Client_t;
     Status      : in out Status_t);

  -- proc_map : jack_client_open
  procedure Open_With_Server
    (Client_Name : in     String;
     Options     : in     Options_t;
     Client      :    out Client_t;
     Status      : in out Status_t;
     Server_Name : in     String);

private

  type Client_t is new System.Address;

  Invalid_Client : constant Client_t := Client_t (System.Null_Address);

  function Map_Status_To_Thin (Status : Status_t) return Thin.Status_t;
  pragma Inline (Map_Status_To_Thin);

  function Map_Thin_To_Status (Status : Thin.Status_t) return Status_t;
  pragma Inline (Map_Thin_To_Status);

  function Map_Options_To_Thin (Options : Options_t) return Thin.Options_t;
  pragma Inline (Map_Options_To_Thin);

  function Map_Thin_To_Options (Options : Thin.Options_t) return Options_t;
  pragma Inline (Map_Thin_To_Options);

end Jack.Client;
