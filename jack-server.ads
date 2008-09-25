with jack.types;
with jack.transport;

generic
  type user_data_t is private;

package jack.server is
  package types is new jack.types (user_data_t => user_data_t);
  package transport is new jack.transport (user_data_t => user_data_t);

  -- API

  function is_realtime (client : types.client_t) return boolean;
  pragma inline (is_realtime);

  function get_sample_rate (client : types.client_t) return types.num_frames_t;
  pragma import (c, get_sample_rate, "jack_get_sample_rate");

  function get_buffer_size (client : types.client_t) return types.num_frames_t;
  pragma import (c, get_buffer_size, "jack_get_buffer_size");

end jack.server;
