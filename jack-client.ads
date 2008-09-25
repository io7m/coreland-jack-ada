with jack.types;
with jack.transport;

generic
  type user_data_t is private;

package jack.client is
  package types is new jack.types (user_data_t => user_data_t);
  package transport is new jack.transport (user_data_t => user_data_t);

  type shutdown_callback_t is access procedure
    (user_data : types.user_data_access_t);

  -- API

  function open
    (name    : string;
     options : types.options_t;
     status  : types.status_access_t) return types.client_t;
  pragma inline (open);

  function close (client : types.client_t) return types.integer_t;
  pragma import (c, close, "jack_client_close");

  function name_size return types.integer_t;
  pragma import (c, name_size, "jack_client_name_size");

  function get_name (client : types.client_t) return string;
  pragma inline (get_name);

  procedure on_shutdown
    (client    : types.client_t;
     callback  : shutdown_callback_t;
     user_data : types.user_data_access_t);
  pragma import (c, on_shutdown, "jack_on_shutdown");

  function set_process_callback
    (client    : types.client_t;
     callback  : types.process_callback_t;
     user_data : types.user_data_access_t) return types.integer_t;
  pragma import (c, set_process_callback, "jack_set_process_callback");

  function set_thread_init_callback
    (client    : types.client_t;
     callback  : types.init_callback_t;
     user_data : types.user_data_access_t) return types.integer_t;
  pragma import (c, set_thread_init_callback, "jack_set_thread_init_callback");

  function set_freewheel_callback
    (client    : types.client_t;
     callback  : types.freewheel_callback_t;
     user_data : types.user_data_access_t) return types.integer_t;
  pragma import (c, set_freewheel_callback, "jack_set_freewheel_callback");

  function set_freewheel
    (client : types.client_t;
     enable : boolean) return types.integer_t;
  pragma inline (set_freewheel);

  function set_buffer_size
    (client     : types.client_t;
     num_frames : types.num_frames_t) return types.integer_t;
  pragma import (c, set_buffer_size, "jack_set_buffer_size");

  function set_buffer_size_callback
    (client     : types.client_t;
     callback   : types.buffer_size_callback_t;
     user_data  : types.user_data_access_t) return types.integer_t;
  pragma import (c, set_buffer_size_callback, "jack_set_buffer_size_callback");

  function set_sample_rate_callback
    (client     : types.client_t;
     callback   : types.sample_rate_callback_t;
     user_data  : types.user_data_access_t) return types.integer_t;
  pragma import (c, set_sample_rate_callback, "jack_set_sample_rate_callback");

  function set_client_registration_callback
    (client     : types.client_t;
     callback   : types.client_register_callback_t;
     user_data  : types.user_data_access_t) return types.integer_t;
  pragma import (c, set_client_registration_callback, "jack_set_client_registration_callback");

  function set_port_registration_callback
    (client     : types.client_t;
     callback   : types.port_register_callback_t;
     user_data  : types.user_data_access_t) return types.integer_t;
  pragma import (c, set_port_registration_callback, "jack_set_port_registration_callback");

  function set_graph_order_callback
    (client     : types.client_t;
     callback   : types.graph_order_callback_t;
     user_data  : types.user_data_access_t) return types.integer_t;
  pragma import (c, set_graph_order_callback, "jack_set_graph_order_callback");

  function set_xrun_callback
    (client     : types.client_t;
     callback   : types.xrun_callback_t;
     user_data  : types.user_data_access_t) return types.integer_t;
  pragma import (c, set_xrun_callback, "jack_set_xrun_callback");

  function activate (client : types.client_t) return types.integer_t;
  pragma import (c, activate, "jack_activate");

  function deactivate (client : types.client_t) return types.integer_t;
  pragma import (c, deactivate, "jack_deactivate");

end jack.client;
