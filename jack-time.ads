with jack.types;
with jack.transport;

generic
  type user_data_t is private;

package jack.time is
  package types is new jack.types (user_data_t => user_data_t);
  package transport is new jack.transport (user_data_t => user_data_t);

  -- API

  function frames_since_cycle_start (client : types.client_t) return types.num_frames_t;
  pragma import (c, frames_since_cycle_start, "jack_frames_since_cycle_start");

  function frame_time (client : types.client_t) return types.num_frames_t;
  pragma import (c, frame_time, "jack_frame_time");

  function last_frame_time (client : types.client_t) return types.num_frames_t;
  pragma import (c, last_frame_time, "jack_last_frame_time");

  function frames_to_time
    (client : types.client_t;
     frames : types.num_frames_t) return types.time_t;
  pragma import (c, frames_to_time, "jack_frames_to_time");

  function time_to_frames
    (client : types.client_t;
     time   : types.time_t) return types.num_frames_t;
  pragma import (c, time_to_frames, "jack_time_to_frames");

  function get_time return types.time_t;
  pragma import (c, get_time, "jack_get_time");

  function cpu_load (client : types.client_t) return types.float_t;
  pragma import (c, cpu_load, "jack_cpu_load");

end jack.time;
