with C_String;
with Interfaces.C;

package body Jack.Client is
  package C renames Interfaces.C;

  use type Thin.Status_t;
  use type System.Address;

  --
  -- Status and option mapping.
  --

  type Status_Map_t is array (Status_Selector_t) of Thin.Status_t;

  Status_Map : constant Status_Map_t := Status_Map_t'
    (Failure               => Thin.JackFailure,
     Invalid_Option        => Thin.JackInvalidOption,
     Name_Not_Unique       => Thin.JackNameNotUnique,
     Server_Started        => Thin.JackServerStarted,
     Server_Failed         => Thin.JackServerFailed,
     Server_Error          => Thin.JackServerError,
     No_Such_Client        => Thin.JackNoSuchClient,
     Load_Failure          => Thin.JackLoadFailure,
     Init_Failure          => Thin.JackInitFailure,
     Shared_Memory_Failure => Thin.JackShmFailure,
     Version_Error         => Thin.JackVersionError);

  type Options_Map_t is array (Option_Selector_t) of Thin.Options_t;

  Options_Map : constant Options_Map_t := Options_Map_t'
    (Do_Not_Start_Server => Thin.JackNoStartServer,
     Use_Exact_Name      => Thin.JackUseExactName,
     Server_Name         => Thin.JackServerName,
     Load_Name           => Thin.JackLoadName,
     Load_Initialize     => Thin.JackLoadInit);

  function Map_Options_To_Thin (Options : Options_t) return Thin.Options_t is
    Return_Options : Thin.Options_t := 0;
  begin
    for Selector in Options_t'Range loop
      if Options (Selector) then
        Return_Options := Return_Options or Options_Map (Selector);
      end if;
    end loop;
    return Return_Options;
  end Map_Options_To_Thin;

  function Map_Status_To_Thin (Status : Status_t) return Thin.Status_t is
    Return_Status : Thin.Status_t := 0;
  begin
    for Selector in Status_t'Range loop
      if Status (Selector) then
        Return_Status := Return_Status or Status_Map (Selector);
      end if;
    end loop;
    return Return_Status;
  end Map_Status_To_Thin;

  function Map_Thin_To_Options (Options : Thin.Options_t) return Options_t is
    Return_Options : Options_t := (others => False);
  begin
    for Selector in Options_t'Range loop
      Return_Options (Selector) :=
        (Options and Options_Map (Selector)) = Options_Map (Selector);
    end loop;
    return Return_Options;
  end Map_Thin_To_Options;

  function Map_Thin_To_Status (Status : Thin.Status_t) return Status_t is
    Return_Status : Status_t := (others => False);
  begin
    for Selector in Status_t'Range loop
      Return_Status (Selector) :=
        (Status and Status_Map (Selector)) = Status_Map (Selector);
    end loop;
    return Return_Status;
  end Map_Thin_To_Status;

  --
  -- Open
  --

  procedure Open
    (Client_Name : in     String;
     Options     : in     Options_t;
     Client      :    out Client_t;
     Status      : in out Status_t)
  is
    C_Options : constant Thin.Options_t := Map_Options_To_Thin (Options);
    C_Name    : aliased C.char_array   := C.To_C (Client_Name);
    C_Status  : aliased Thin.Status_t;
    C_Client  : System.Address;
  begin
    C_Client := Thin.Client_Open
      (Client_Name => C_String.To_C_String (C_Name'Unchecked_Access),
       Options     => C_Options,
       Status      => C_Status'Address);
    Status := Map_Thin_To_Status (C_Status);

    if C_Client = System.Null_Address then
      Client := Invalid_Client;
    else
      Client := Client_t (C_Client);
    end if;
  end Open;

  procedure Open_With_Server
    (Client_Name : in     String;
     Options     : in     Options_t;
     Client      :    out Client_t;
     Status      : in out Status_t;
     Server_Name : in     String)
  is
  begin
    null;
  end Open_With_Server;

end Jack.Client;
