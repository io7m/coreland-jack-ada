with jack.types;
with jack.transport;

generic package jack.client is
  package jack_types is new jack.types;
  package jack_transport is new jack.transport;

  type shutdown_callback_t is access procedure
    (user_data : jack_types.user_data_access_t);
  pragma convention (c, shutdown_callback_t);

  null_client : constant jack_types.client_t := jack_types.client_t (jack_types.null_ptr);

  -- API

  function open
    (name    : string;
     options : jack_types.options_t;
     status  : jack_types.status_access_t) return jack_types.client_t;
  pragma inline (open);

  function close (client : jack_types.client_t) return jack_types.integer_t;
  pragma import (c, close, "jack_client_close");

  function name_size return jack_types.integer_t;
  pragma import (c, name_size, "jack_client_name_size");

  function get_name (client : jack_types.client_t) return string;
  pragma inline (get_name);

  procedure on_shutdown
    (client    : jack_types.client_t;
     callback  : shutdown_callback_t;
     user_data : jack_types.user_data_access_t);
  pragma import (c, on_shutdown, "jack_on_shutdown");

  function set_process_callback
    (client    : jack_types.client_t;
     callback  : jack_types.process_callback_t;
     user_data : jack_types.user_data_access_t) return jack_types.integer_t;
  pragma import (c, set_process_callback, "jack_set_process_callback");

  function set_thread_init_callback
    (client    : jack_types.client_t;
     callback  : jack_types.init_callback_t;
     user_data : jack_types.user_data_access_t) return jack_types.integer_t;
  pragma import (c, set_thread_init_callback, "jack_set_thread_init_callback");

  function set_freewheel_callback
    (client    : jack_types.client_t;
     callback  : jack_types.freewheel_callback_t;
     user_data : jack_types.user_data_access_t) return jack_types.integer_t;
  pragma import (c, set_freewheel_callback, "jack_set_freewheel_callback");

  function set_freewheel
    (client : jack_types.client_t;
     enable : boolean) return jack_types.integer_t;
  pragma inline (set_freewheel);

  function set_buffer_size
    (client     : jack_types.client_t;
     num_frames : jack_types.num_frames_t) return jack_types.integer_t;
  pragma import (c, set_buffer_size, "jack_set_buffer_size");

  function set_buffer_size_callback
    (client     : jack_types.client_t;
     callback   : jack_types.buffer_size_callback_t;
     user_data  : jack_types.user_data_access_t) return jack_types.integer_t;
  pragma import (c, set_buffer_size_callback, "jack_set_buffer_size_callback");

  function set_sample_rate_callback
    (client     : jack_types.client_t;
     callback   : jack_types.sample_rate_callback_t;
     user_data  : jack_types.user_data_access_t) return jack_types.integer_t;
  pragma import (c, set_sample_rate_callback, "jack_set_sample_rate_callback");

  function set_client_registration_callback
    (client     : jack_types.client_t;
     callback   : jack_types.client_register_callback_t;
     user_data  : jack_types.user_data_access_t) return jack_types.integer_t;
  pragma import (c, set_client_registration_callback, "jack_set_client_registration_callback");

  function set_port_registration_callback
    (client     : jack_types.client_t;
     callback   : jack_types.port_register_callback_t;
     user_data  : jack_types.user_data_access_t) return jack_types.integer_t;
  pragma import (c, set_port_registration_callback, "jack_set_port_registration_callback");

  function set_graph_order_callback
    (client     : jack_types.client_t;
     callback   : jack_types.graph_order_callback_t;
     user_data  : jack_types.user_data_access_t) return jack_types.integer_t;
  pragma import (c, set_graph_order_callback, "jack_set_graph_order_callback");

  function set_xrun_callback
    (client     : jack_types.client_t;
     callback   : jack_types.xrun_callback_t;
     user_data  : jack_types.user_data_access_t) return jack_types.integer_t;
  pragma import (c, set_xrun_callback, "jack_set_xrun_callback");

  function activate (client : jack_types.client_t) return jack_types.integer_t;
  pragma import (c, activate, "jack_activate");

  function deactivate (client : jack_types.client_t) return jack_types.integer_t;
  pragma import (c, deactivate, "jack_deactivate");

end jack.client;
