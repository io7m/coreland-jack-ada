with C_String.Arrays;
with C_String;
with Interfaces.C;
with System.Address_To_Access_Conversions;

package body Jack.Client is
  package C renames Interfaces.C;

  use type C.int;
  use type Port_Name_t;
  use type System.Address;
  use type Thin.Port_Flags_t;
  use type Thin.Status_t;

  --
  -- Activate
  --

  procedure Activate
    (Client : in     Client_t;
     Failed :    out Boolean)
  is
    C_Return : constant C.int := Thin.Activate (System.Address (Client));
  begin
    Failed := C_Return /= 0;
  end Activate;

  --
  -- Close
  --

  procedure Close
    (Client : in     Client_t;
     Failed :    out Boolean) is
  begin
    Failed := Thin.Client_Close (System.Address (Client)) /= 0;
  end Close;

  --
  -- Compare
  --

  function Compare
    (Left  : in Client_t;
     Right : in Client_t) return Boolean is
  begin
    return System.Address (Left) = System.Address (Right);
  end Compare;

  function Compare
    (Left  : in Port_t;
     Right : in Port_t) return Boolean is
  begin
    return System.Address (Left) = System.Address (Right);
  end Compare;

  --
  -- Connect
  --

  procedure Connect
    (Client           : in     Client_t;
     Source_Port      : in     Port_Name_t;
     Destination_Port : in     Port_Name_t;
     Failed           :    out Boolean)
  is
    C_Source : aliased C.char_array := C.To_C (Port_Names.To_String (Source_Port));
    C_Dest   : aliased C.char_array := C.To_C (Port_Names.To_String (Destination_Port));
    C_Result : constant C.int       := Thin.Connect
      (Client           => System.Address (Client),
       Source_Port      => C_String.To_C_String (C_Source'Unchecked_Access),
       Destination_Port => C_String.To_C_String (C_Dest'Unchecked_Access));
  begin
    Failed := C_Result /= 0;
  end Connect;

  --
  -- Deactivate
  --

  procedure Deactivate
    (Client : in     Client_t;
     Failed :    out Boolean) is
  begin
    Failed := 0 /= Thin.Deactivate (To_Address (Client));
  end Deactivate;

  --
  -- Disconnect
  --

  procedure Disconnect
    (Client           : in     Client_t;
     Source_Port      : in     Port_Name_t;
     Destination_Port : in     Port_Name_t;
     Failed           :    out Boolean)
  is
    C_Source : aliased C.char_array := C.To_C (Port_Names.To_String (Source_Port));
    C_Dest   : aliased C.char_array := C.To_C (Port_Names.To_String (Destination_Port));
    C_Result : constant C.int       := Thin.Disconnect
      (Client           => System.Address (Client),
       Source_Port      => C_String.To_C_String (C_Source'Unchecked_Access),
       Destination_Port => C_String.To_C_String (C_Dest'Unchecked_Access));
  begin
    Failed := C_Result /= 0;
  end Disconnect;

  --
  -- Get_Ports
  --

  procedure Get_Ports_Free (Data : System.Address);
  pragma Import (C, Get_Ports_Free, "jack_ada_client_get_ports_free");

  procedure Get_Ports
    (Client            : in     Client_t;
     Port_Name_Pattern : in     String           := "";
     Port_Type_Pattern : in     String           := "";
     Port_Flags        : in     Port_Flags_t     := (others => False);
     Ports             :    out Port_Name_Set_t)
  is
    Name     : Port_Name_t;
    Size     : Natural;
    C_Flags  : constant Thin.Port_Flags_t := Map_Port_Flags_To_Thin (Port_Flags);
    C_Name   : aliased C.char_array       := C.To_C (Port_Name_Pattern);
    C_Type   : aliased C.char_array       := C.To_C (Port_Type_Pattern);
    Ptr_Name : C_String.String_Ptr_t;
    Ptr_Type : C_String.String_Ptr_t;
    Address  : C_String.Arrays.Pointer_Array_t;
  begin
    if Port_Name_Pattern /= Port_Names.Null_Bounded_String then
      Ptr_Name := C_String.To_C_String (C_Name'Unchecked_Access);
    end if;
    if Port_Type_Pattern /= "" then
      Ptr_Type := C_String.To_C_String (C_Type'Unchecked_Access);
    end if;

    Address := Thin.Get_Ports
     (Client            => System.Address (Client),
      Port_Name_Pattern => Ptr_Name,
      Type_Name_Pattern => Ptr_Type,
      Flags             => C_Flags);

    if Address /= System.Null_Address then
      Size := C_String.Arrays.Size_Terminated (Address);
      if Size > 0 then
        for Index in 0 .. Size - 1 loop
          Port_Names.Set_Bounded_String
            (Source => C_String.Arrays.Index_Terminated (Address, Index),
             Target => Name);
          Port_Name_Sets.Insert (Ports, Name);
        end loop;
      end if;

      -- The strings returned by jack_get_ports are heap allocated.
      Get_Ports_Free (System.Address (Address));
    end if;
  end Get_Ports;

  --
  -- Status, option and flag mapping.
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

  type Port_Flags_Map_t is array (Port_Flag_Selector_t) of Thin.Port_Flags_t;

  Port_Flags_Map : constant Port_Flags_Map_t := Port_Flags_Map_t'
    (Port_Is_Input    => Thin.JackPortIsInput,
     Port_Is_Output   => Thin.JackPortIsOutput,
     Port_Is_Physical => Thin.JackPortIsPhysical,
     Port_Can_Monitor => Thin.JackPortCanMonitor,
     Port_Is_Terminal => Thin.JackPortIsTerminal);

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

  function Map_Port_Flags_To_Thin (Port_Flags : Port_Flags_t) return Thin.Port_Flags_t is
    Return_Port_Flags : Thin.Port_Flags_t := 0;
  begin
    for Selector in Port_Flags_t'Range loop
      if Port_Flags (Selector) then
        Return_Port_Flags := Return_Port_Flags or Port_Flags_Map (Selector);
      end if;
    end loop;
    return Return_Port_Flags;
  end Map_Port_Flags_To_Thin;

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

  function Map_Thin_To_Port_Flags (Port_Flags : Thin.Port_Flags_t) return Port_Flags_t is
    Return_Port_Flags : Port_Flags_t := (others => False);
  begin
    for Selector in Port_Flags_t'Range loop
      Return_Port_Flags (Selector) :=
        (Port_Flags and Port_Flags_Map (Selector)) = Port_Flags_Map (Selector);
    end loop;
    return Return_Port_Flags;
  end Map_Thin_To_Port_Flags;

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
    function C_Client_Open
      (Client_Name : C_String.String_Not_Null_Ptr_t;
       Options     : Thin.Options_t;
       Status      : System.Address) return System.Address;
    pragma Import (C, C_Client_Open, "jack_ada_client_open");

    C_Client  : System.Address;
    C_Name    : aliased C.char_array    := C.To_C (Client_Name);
    C_Options : constant Thin.Options_t := Map_Options_To_Thin (Options);
    C_Status  : aliased Thin.Status_t   := 0;
  begin
    pragma Assert (Client_Name /= "");

    C_Client := C_Client_Open
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

  --
  -- Port_Is_Mine
  --

  function Port_Is_Mine
    (Client : in Client_t;
     Port   : in Port_t) return Boolean is
  begin
    return 1 = Thin.Port_Is_Mine
      (Client => To_Address (Client),
       Port   => To_Address (Port));
  end Port_Is_Mine;

  --
  -- Port_Register
  --

  procedure Port_Register
    (Client      : in     Client_t;
     Port        :    out Port_t;
     Port_Name   : in     Port_Name_t;
     Port_Type   : in     Port_Type_t  := Default_Audio_Type;
     Port_Flags  : in     Port_Flags_t := (others => False);
     Buffer_Size : in     Natural      := 0)
  is
    C_Flags  : constant Thin.Port_Flags_t := Map_Port_Flags_To_Thin (Port_Flags);
    C_Name   : aliased C.char_array       := C.To_C (Port_Names.To_String (Port_Name));
    C_Type   : aliased C.char_array       := C.To_C (Port_Types.To_String (Port_Type));
    C_Port   : System.Address;
  begin
    C_Port := Thin.Port_Register
      (Client      => System.Address (Client),
       Port_Name   => C_String.To_C_String (C_Name'Unchecked_Access),
       Port_Type   => C_String.To_C_String (C_Type'Unchecked_Access),
       Flags       => C_Flags,
       Buffer_Size => C.unsigned_long (Buffer_Size));

    if C_Port = System.Null_Address then
      Port := Invalid_Port;
    else
      Port := Port_t (C_Port);
    end if;
  end Port_Register;

  --
  -- Generic_Callbacks
  --

  package body Generic_Callbacks is

    package Convert_Process is new
      System.Address_To_Access_Conversions (Process_Callback_State_t);

    function C_Set_Process_Callback
      (Client   : System.Address;
       Callback : access procedure
        (Number_Of_Frames : Thin.Number_Of_Frames_t;
         Data             : System.Address);
       Data     : System.Address) return Thin.Integer_t;
    pragma Import (C, C_Set_Process_Callback, "jack_set_process_callback");

    procedure Process_Callback_Inner
      (Number_Of_Frames : Thin.Number_Of_Frames_t;
       Data             : System.Address)
    is
      State : Process_Callback_State_t;
      for State'Address use Data;
      pragma Import (Ada, State);
    begin
      State.Callback
        (Number_Of_Frames => Number_Of_Frames_t (Number_Of_Frames),
         User_Data        => State.User_Data);
    end Process_Callback_Inner;

    procedure Set_Process_Callback
      (Client    : in     Client_t;
       State     : in     Process_Callback_State_Access_t;
       Failed    :    out Boolean)
    is
      Pointer : constant Convert_Process.Object_Pointer :=
        Convert_Process.Object_Pointer (State);
    begin
      Failed := 0 /= C_Set_Process_Callback
        (Client   => System.Address (Client),
         Callback => Process_Callback_Inner'Access,
         Data     => Convert_Process.To_Address (Pointer));
    end Set_Process_Callback;

  end Generic_Callbacks;

  --
  -- Recompute_Total_Latencies
  --

  procedure Recompute_Total_Latencies
    (Client : in     Client_t;
     Failed :    out Boolean) is
  begin
    Failed := 1 = Thin.Recompute_Total_Latencies (To_Address (Client));
  end Recompute_Total_Latencies;

  --
  -- Recompute_Total_Latency
  --

  procedure Recompute_Total_Latency
    (Client : in     Client_t;
     Port   : in     Port_t;
     Failed :    out Boolean) is
  begin
    Failed := 1 = Thin.Recompute_Total_Latency
      (Client => To_Address (Client),
       Port   => To_Address (Port));
  end Recompute_Total_Latency;

  --
  -- To_Address
  --

  function To_Address (Client : in Client_t) return System.Address is
  begin
    return System.Address (Client);
  end To_Address;

  function To_Address (Port : in Port_t) return System.Address is
  begin
    return System.Address (Port);
  end To_Address;

  --
  -- Total_Latency
  --

  function Total_Latency
    (Client : in Client_t;
     Port   : in Port_t) return Number_Of_Frames_t is
  begin
    return Number_Of_Frames_t (Thin.Port_Get_Total_Latency
      (Client => To_Address (Client),
       Port   => To_Address (Port)));
  end Total_Latency;

end Jack.Client;
