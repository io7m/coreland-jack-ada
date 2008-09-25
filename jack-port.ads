with jack.types;
with jack.transport;

generic
  type user_data_t is private;

package jack.port is
  package types is new jack.types (user_data_t => user_data_t);
  package transport is new jack.transport (user_data_t => user_data_t);

  -- API

  function register
    (client      : types.client_t;
     port_name   : string;
     port_type   : string;
     flags       : types.port_flags_t;
     buffer_size : types.buffer_size_t) return types.port_t;
  pragma inline (register);

  function unregister
    (client : types.client_t;
     port   : types.port_t) return types.integer_t;
  pragma import (c, unregister, "jack_port_unregister");

  function get_buffer
    (port       : types.port_t;
     num_frames : types.num_frames_t) return types.sample_access_t;
  pragma import (c, buffer, "jack_port_get_buffer");

  function name (port : types.port_t) return string;
  pragma inline (name);

  function short_name (port : types.port_t) return string;
  pragma inline (short_name);

  function flags (port : types.port_t) return types.port_flags_t;
  pragma import (c, flags, "jack_port_flags");

  function get_type (port : types.port_t) return string;
  pragma inline (get_type);

  function is_mine
    (client : types.client_t;
     port   : types.port_t) return boolean;
  pragma inline (is_mine);

  function connected (port : types.port_t) return types.integer_t;
  pragma import (c, connected, "jack_port_connected");

  function connected_to
    (port : types.port_t;
     name : string) return boolean;
  pragma inline (connected_to);

  -- missing: jack_port_get_connections
  -- missing: jack_port_get_all_connections

  function tie
    (source      : types.port_t;
     destination : types.port_t) return types.integer_t;
  pragma import (c, tie, "jack_port_tie");

  function untie (port : types.port_t) return types.integer_t;
  pragma import (c, untie, "jack_port_untie");

  function get_latency (port : types.port_t) return types.num_frames_t;
  pragma import (c, get_latency, "jack_port_get_latency");

  function get_total_latency
    (client : types.client_t;
     port   : types.port_t) return types.num_frames_t;
  pragma import (c, get_total_latency, "jack_port_get_total_latency");

  procedure set_latency
    (port       : types.port_t;
     num_frames : types.num_frames_t);
  pragma import (c, set_latency, "jack_port_set_latency");

  function recompute_total_latency
    (client : types.client_t;
     port   : types.port_t) return types.integer_t;
  pragma import (c, recompute_total_latency, "jack_recompute_total_latency");

  function recompute_total_latencies
    (client : types.client_t) return types.integer_t;
  pragma import (c, recompute_total_latencies, "jack_recompute_total_latencies");

  function set_name
    (port : types.port_t;
     name : string) return types.integer_t;
  pragma inline (set_name);

  function set_alias
    (port  : types.port_t;
     alias : string) return types.integer_t;
  pragma inline (set_alias);

  function unset_alias
    (port  : types.port_t;
     alias : string) return types.integer_t;
  pragma inline (unset_alias);

  -- missing: jack_port_get_aliases

  function request_monitor
    (port   : types.port_t;
     enable : boolean) return types.integer_t;
  pragma inline (request_monitor);

  function request_monitor_by_name
    (port   : types.port_t;
     name   : string;
     enable : boolean) return types.integer_t;
  pragma inline (request_monitor_by_name);

  function ensure_monitor
    (port   : types.port_t;
     enable : boolean) return types.integer_t;
  pragma inline (ensure_monitor);

  function monitoring (port : types.port_t) return boolean;
  pragma inline (monitoring);

  function connect
    (client      : types.client_t;
     source      : string;
     destination : string) return types.integer_t;
  pragma inline (connect);

  function disconnect
    (client      : types.client_t;
     source      : string;
     destination : string) return types.integer_t;
  function disconnect
    (client : types.client_t;
     port   : types.port_t) return types.integer_t;
  pragma inline (disconnect);

  function name_size return types.integer_t;
  pragma import (c, name_size, "jack_port_name_size");

  function type_size return types.integer_t;
  pragma import (c, type_size, "jack_port_type_size");

  -- missing: jack_get_ports

  function by_name
    (client : types.client_t;
     name   : string) return types.port_t;
  pragma inline (by_name);

  function by_id
    (client : types.client_t;
     id     : types.port_id_t) return types.port_t;
  pragma inline (by_id);

end jack.port;
