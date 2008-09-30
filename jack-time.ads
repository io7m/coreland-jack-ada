with jack.types;
with jack.transport;

generic package jack.time is
  package jack_types is new jack.types;
  package jack_transport is new jack.transport;

  -- API

  function frames_since_cycle_start (client : jack_types.client_t) return jack_types.num_frames_t;
  pragma import (c, frames_since_cycle_start, "jack_frames_since_cycle_start");

  function frame_time (client : jack_types.client_t) return jack_types.num_frames_t;
  pragma import (c, frame_time, "jack_frame_time");

  function last_frame_time (client : jack_types.client_t) return jack_types.num_frames_t;
  pragma import (c, last_frame_time, "jack_last_frame_time");

  function frames_to_time
    (client : jack_types.client_t;
     frames : jack_types.num_frames_t) return jack_types.time_t;
  pragma import (c, frames_to_time, "jack_frames_to_time");

  function time_to_frames
    (client : jack_types.client_t;
     time   : jack_types.time_t) return jack_types.num_frames_t;
  pragma import (c, time_to_frames, "jack_time_to_frames");

  function get_time return jack_types.time_t;
  pragma import (c, get_time, "jack_get_time");

  function cpu_load (client : jack_types.client_t) return jack_types.float_t;
  pragma import (c, cpu_load, "jack_cpu_load");

end jack.time;
