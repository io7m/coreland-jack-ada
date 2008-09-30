with jack.types;
with jack.transport;

generic package jack.server is
  package jack_types is new jack.types;
  package jack_transport is new jack.transport;

  -- API

  function is_realtime (client : jack_types.client_t) return boolean;
  pragma inline (is_realtime);

  function get_sample_rate (client : jack_types.client_t) return jack_types.num_frames_t;
  pragma import (c, get_sample_rate, "jack_get_sample_rate");

  function get_buffer_size (client : jack_types.client_t) return jack_types.num_frames_t;
  pragma import (c, get_buffer_size, "jack_get_buffer_size");

end jack.server;
