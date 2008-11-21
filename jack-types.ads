with jack.sample;
with interfaces.c;
with system;

generic package jack.types is
  package c renames interfaces.c;
  package jack_sample is new jack.sample;

  -- generic access
  type user_data_access_t is access all user_data_t;
  pragma convention (c, user_data_access_t);

  -- generic void pointer type
  subtype void_ptr_t is system.address;
  null_ptr : constant void_ptr_t := system.null_address;

  --
  -- standard integer set
  --

  type integer_t is new c.int;
  type integer_access_t is access all integer_t;
  pragma convention (c, integer_access_t);

  type unsigned_t is new c.unsigned;
  type unsigned_access_t is access all unsigned_t;
  pragma convention (c, unsigned_access_t);

  type float_t is new c.c_float;
  type float_access_t is access all float_t;
  pragma convention (c, float_access_t);

  type double_t is new c.double;
  type double_access_t is access all double_t;
  pragma convention (c, double_access_t);

  type boolean_t is (false, true);
   for boolean_t use (false => 0, true => 1);
   for boolean_t'size use c.unsigned'size;
  pragma convention (c, boolean_t);

  type boolean_access_t is access all boolean_t;
  pragma convention (c, boolean_access_t);

  type int8_t is range -16#7f# .. 16#7f#;
  type int16_t is range -16#7fff# .. 16#7fff#;
  type int32_t is range -16#7fffffff# .. 16#7fffffff#;
  type int64_t is range -16#7fffffffffffffff# .. 16#7fffffffffffffff#;

  for int8_t'size use 8;
  for int16_t'size use 16;
  for int32_t'size use 32;
  for int64_t'size use 64;

  pragma convention (c, int8_t);
  pragma convention (c, int16_t);
  pragma convention (c, int32_t);
  pragma convention (c, int64_t);

  type int8_ptr_t is access all int8_t;
  type int16_ptr_t is access all int16_t;
  type int32_ptr_t is access all int32_t;
  type int64_ptr_t is access all int64_t;

  pragma convention (c, int8_ptr_t);
  pragma convention (c, int16_ptr_t);
  pragma convention (c, int32_ptr_t);
  pragma convention (c, int64_ptr_t);

  type uint8_t is mod 2 ** 8;
  type uint16_t is mod 2 ** 16;
  type uint32_t is mod 2 ** 32;
  type uint64_t is mod 2 ** 64;

  for uint8_t'size use 8;
  for uint16_t'size use 16;
  for uint32_t'size use 32;
  for uint64_t'size use 64;

  pragma convention (c, uint8_t);
  pragma convention (c, uint16_t);
  pragma convention (c, uint32_t);
  pragma convention (c, uint64_t);

  type uint8_ptr_t is access all uint8_t;
  type uint16_ptr_t is access all uint16_t;
  type uint32_ptr_t is access all uint32_t;
  type uint64_ptr_t is access all uint64_t;

  pragma convention (c, uint8_ptr_t);
  pragma convention (c, uint16_ptr_t);
  pragma convention (c, uint32_ptr_t);
  pragma convention (c, uint64_ptr_t);

  --
  -- jack types
  --

  type shm_size_t is new int32_t;
  type num_frames_t is new uint32_t;
  type time_t is new uint64_t;
  type port_id_t is new uint32_t;

  type client_t is new void_ptr_t;
  type port_t is new void_ptr_t;

  -- audio callback type
  type process_callback_t is access function
    (num_frames : num_frames_t;
     userdata   : user_data_access_t) return integer_t;
  pragma convention (c, process_callback_t);

  -- initialisation callback type
  type init_callback_t is access function
    (userdata : user_data_access_t) return integer_t;
  pragma convention (c, init_callback_t);

  -- graph reordering callback type
  type graph_order_callback_t is access function
    (userdata : user_data_access_t) return integer_t;
  pragma convention (c, graph_order_callback_t);

  -- xrun callback type
  type xrun_callback_t is access function
    (userdata : user_data_access_t) return integer_t;
  pragma convention (c, xrun_callback_t);

  -- buffer size callback type
  type buffer_size_callback_t is access function
    (num_frames : num_frames_t;         
     userdata   : user_data_access_t) return integer_t;
  pragma convention (c, buffer_size_callback_t);

  -- sample rate callback type
  type sample_rate_callback_t is access function
    (num_frames : num_frames_t;         
     userdata   : user_data_access_t) return integer_t;
  pragma convention (c, sample_rate_callback_t);

  -- port registration callback type
  type port_register_callback_t is access procedure
    (port     : port_id_t;
     register : boolean_t;
     userdata : user_data_access_t);
  pragma convention (c, port_register_callback_t);

  -- client registration callback type
  type client_register_callback_t is access procedure
    (name     : string;
     register : boolean_t;
     userdata : user_data_access_t);
  pragma convention (c, client_register_callback_t);

  -- port connection callback type
  type port_connect_callback_t is access procedure
    (port_a   : port_id_t;
     port_b   : port_id_t;
     connect  : boolean_t;
     userdata : user_data_access_t);
  pragma convention (c, port_connect_callback_t);

  -- freewheeling callback type
  type freewheel_callback_t is access procedure
    (starting : boolean_t;
     userdata : user_data_access_t);
  pragma convention (c, freewheel_callback_t);

  -- opaque type.
  type int_client_t is new uint64_t;

  -- sample type
  type sample_t is new jack_sample.type_t;
  type sample_access_t is access all sample_t;
  pragma convention (c, sample_access_t);

  -- port flags
  type port_flags_t is new unsigned_t;
  port_is_input    : constant port_flags_t := 16#01#;
  port_is_output   : constant port_flags_t := 16#02#;
  port_is_physical : constant port_flags_t := 16#04#;
  port_can_monitor : constant port_flags_t := 16#08#;
  port_is_terminal : constant port_flags_t := 16#10#;

  -- options
  type options_t is new unsigned_t;
  null_option     : constant options_t := 16#00#;
  no_start_server : constant options_t := 16#01#;
  use_exact_name  : constant options_t := 16#02#;
  server_name     : constant options_t := 16#04#;
  load_name       : constant options_t := 16#08#;
  load_init       : constant options_t := 16#10#;

  -- external client options
  open_options : constant options_t := server_name or no_start_server or use_exact_name;
  load_options : constant options_t := load_init or load_name or use_exact_name;

  -- status bits
  type status_t is new unsigned_t;
  type status_access_t is access all status_t;
  pragma convention (c, status_access_t);

  failure               : constant status_t := 16#01#;
  invalid_option        : constant status_t := 16#02#;
  name_not_unique       : constant status_t := 16#04#;
  server_started        : constant status_t := 16#08#;
  server_failed         : constant status_t := 16#10#;
  server_error          : constant status_t := 16#20#;
  no_such_client        : constant status_t := 16#40#;
  load_failure          : constant status_t := 16#80#;
  init_failure          : constant status_t := 16#100#;
  shared_memory_failure : constant status_t := 16#200#;
  version_error         : constant status_t := 16#400#;

  -- buffer size
  subtype buffer_size_t is c.unsigned_long;

end jack.types;
