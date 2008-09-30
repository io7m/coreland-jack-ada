with interfaces.c;
with jack.types;

generic package jack.transport is
  package c renames interfaces.c;
  package jack_types is new jack.types;

  -- transport state
  type state_t is (stopped, rolling, looping, starting);
  for state_t use (stopped  => 0, rolling  => 1, looping  => 2, starting => 3);
  for state_t'size use c.unsigned'size;
  pragma convention (c, state_t);

  -- unique ID
  type unique_t is new jack_types.uint64_t;

  -- position bits
  type position_bits_t is new jack_types.unsigned_t;
  bbt                : constant position_bits_t := 16#10#;
  timecode           : constant position_bits_t := 16#20#;
  bbt_frame_offset   : constant position_bits_t := 16#40#;
  audio_video_ratio  : constant position_bits_t := 16#80#;
  video_frame_offset : constant position_bits_t := 16#100#;

  type padding_t is array (1 .. 7) of jack_types.int32_t;
  pragma convention (c, padding_t);

  -- transport position structure
  type position_t is record
    unique_1                     : unique_t;
    usecs                        : jack_types.time_t;
    frame_rate                   : jack_types.num_frames_t;
    frame                        : jack_types.num_frames_t;
    valid                        : position_bits_t;
    bar                          : jack_types.int32_t;
    beat                         : jack_types.int32_t;
    tick                         : jack_types.int32_t;
    bar_start_tick               : jack_types.double_t;
    beats_per_bar                : jack_types.float_t;
    beat_type                    : jack_types.float_t;
    ticks_per_beat               : jack_types.double_t;
    beats_per_minute             : jack_types.double_t;    
    frame_time                   : jack_types.double_t;
    next_time                    : jack_types.double_t;
    bbt_offset                   : jack_types.num_frames_t;
    audio_frames_per_video_frame : jack_types.float_t;
    video_offset                 : jack_types.num_frames_t;
    padding                      : padding_t;
    unique_2                     : unique_t;
  end record;
  type position_access_t is access all position_t;
  pragma convention (c, position_t);
  pragma convention (c, position_access_t);

  type sync_callback_t is access function
    (state     : state_t;
     position  : position_access_t;
     user_data : jack_types.user_data_access_t) return jack_types.integer_t;
  pragma convention (c, sync_callback_t);

  type timebase_callback_t is access procedure
    (state        : state_t;
     num_frames   : jack_types.num_frames_t;
     position     : position_access_t;
     new_position : jack_types.integer_t;
     user_data    : jack_types.user_data_access_t);
  pragma convention (c, timebase_callback_t);

  -- API

  function release_timebase (client : jack_types.client_t) return jack_types.integer_t;
  pragma import (c, release_timebase, "jack_release_timebase");

  function set_sync_callback
    (client    : jack_types.client_t;
     callback  : sync_callback_t;
     user_data : jack_types.user_data_access_t) return jack_types.integer_t;
  pragma import (c, set_sync_callback, "jack_set_sync_callback");

  function set_sync_timeout
    (client    : jack_types.client_t;
     timeout   : jack_types.time_t) return jack_types.integer_t;
  pragma import (c, set_sync_timeout, "jack_set_sync_timeout");

  function set_timebase_callback
    (client      : jack_types.client_t;
     conditional : jack_types.integer_t;
     callback    : timebase_callback_t;
     user_data   : jack_types.user_data_access_t) return jack_types.integer_t;
  pragma import (c, set_timebase_callback, "jack_set_timebase_callback");

  function locate
    (client : jack_types.client_t;
     frame  : jack_types.num_frames_t) return jack_types.integer_t;
  pragma import (c, locate, "jack_transport_locate");

  function query
    (client   : jack_types.client_t;
     position : position_access_t) return state_t;
  pragma import (c, query, "jack_transport_query");

  function get_current_transport_frame (client : jack_types.client_t) return jack_types.num_frames_t;
  pragma import (c, get_current_transport_frame, "jack_get_current_transport_frame");

  function reposition
    (client   : jack_types.client_t;
     position : position_access_t) return jack_types.integer_t;
  pragma import (c, reposition, "jack_transport_reposition");

  procedure start (client : jack_types.client_t);
  pragma import (c, start, "jack_transport_start");

  procedure stop (client : jack_types.client_t);
  pragma import (c, stop, "jack_transport_stop");

end jack.transport;
