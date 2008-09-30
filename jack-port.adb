with interfaces.c;
with interfaces.c.strings;

package body jack.port is
  package c renames interfaces.c;
  package cs renames interfaces.c.strings;

  use type c.int;

  package cbinds is
    function register
      (client      : jack_types.client_t;
       port_name   : cs.chars_ptr;
       port_type   : cs.chars_ptr;
       flags       : jack_types.port_flags_t;
       buffer_size : jack_types.buffer_size_t) return jack_types.port_t;
    pragma import (c, register, "jack_port_register");

    function name (port : jack_types.port_t) return cs.chars_ptr;
    pragma import (c, name, "jack_port_name");

    function short_name (port : jack_types.port_t) return cs.chars_ptr;
    pragma import (c, short_name, "jack_port_short_name");

    function get_type (port : jack_types.port_t) return cs.chars_ptr;
    pragma import (c, get_type, "jack_port_type");

    function is_mine
      (client : jack_types.client_t;
       port   : jack_types.port_t) return c.int;
    pragma import (c, is_mine, "jack_port_is_mine");

    function set_name
      (port : jack_types.port_t;
       name : cs.chars_ptr) return jack_types.integer_t;
    pragma import (c, set_name, "jack_port_set_name");

    function set_alias
      (port  : jack_types.port_t;
       alias : cs.chars_ptr) return jack_types.integer_t;
    pragma import (c, set_alias, "jack_port_set_alias");

    function unset_alias
      (port  : jack_types.port_t;
       alias : cs.chars_ptr) return jack_types.integer_t;
    pragma import (c, unset_alias, "jack_port_unset_alias");

    function request_monitor
      (port   : jack_types.port_t;
       enable : c.int) return jack_types.integer_t;
    pragma import (c, request_monitor, "jack_port_request_monitor");

    function request_monitor_by_name
      (port   : jack_types.port_t;
       name   : cs.chars_ptr;
       enable : c.int) return jack_types.integer_t;
    pragma import (c, request_monitor_by_name, "jack_port_request_monitor_by_name");

    function ensure_monitor
      (port   : jack_types.port_t;
       enable : c.int) return jack_types.integer_t;
    pragma import (c, ensure_monitor, "jack_port_ensure_monitor");

    function monitoring (port : jack_types.port_t) return c.int;
    pragma import (c, monitoring, "jack_port_monitoring_input");

    function connected_to
      (port : jack_types.port_t;
       name : cs.chars_ptr) return c.int;
    pragma import (c, connected_to, "jack_port_connected_to");

    function connect
      (client      : jack_types.client_t;
       source      : cs.chars_ptr;
       destination : cs.chars_ptr) return jack_types.integer_t;
    pragma import (c, connect, "jack_connect");

    function disconnect
      (client      : jack_types.client_t;
       source      : cs.chars_ptr;
       destination : cs.chars_ptr) return jack_types.integer_t;
    pragma import (c, disconnect, "jack_disconnect");

    function port_disconnect
      (client : jack_types.client_t;
       port   : jack_types.port_t) return jack_types.integer_t;
    pragma import (c, port_disconnect, "jack_port_disconnect");

    function by_name
      (client : jack_types.client_t;
       name   : cs.chars_ptr) return jack_types.port_t;
    pragma import (c, by_name, "jack_port_by_name");
  end cbinds;

  function register
    (client      : jack_types.client_t;
     port_name   : string;
     port_type   : string;
     flags       : jack_types.port_flags_t;
     buffer_size : jack_types.buffer_size_t) return jack_types.port_t
  is
    c_name : aliased c.char_array := c.to_c (port_name);
    c_type : aliased c.char_array := c.to_c (port_type);
  begin
    return cbinds.register
      (client      => client,
       port_name   => cs.to_chars_ptr (c_name'unchecked_access),
       port_type   => cs.to_chars_ptr (c_type'unchecked_access),
       flags       => flags,
       buffer_size => buffer_size);
  end register;

  function name (port : jack_types.port_t) return string is
  begin
    return cs.value (cbinds.name (port));
  end name;

  function short_name (port : jack_types.port_t) return string is
  begin
    return cs.value (cbinds.short_name (port));
  end short_name;

  function get_type (port : jack_types.port_t) return string is
  begin
    return cs.value (cbinds.get_type (port));
  end get_type;

  function is_mine
    (client : jack_types.client_t;
     port   : jack_types.port_t) return boolean is
  begin
    return cbinds.is_mine (client, port) = 1;
  end is_mine;

  function connected_to
    (port : jack_types.port_t;
     name : string) return boolean
  is
    c_name : aliased c.char_array := c.to_c (name);
  begin
    return cbinds.connected_to
      (port, cs.to_chars_ptr (c_name'unchecked_access)) = 1;
  end connected_to;

  function set_name
    (port : jack_types.port_t;
     name : string) return jack_types.integer_t
  is
    c_name : aliased c.char_array := c.to_c (name);
  begin
    return cbinds.set_name (port, cs.to_chars_ptr (c_name'unchecked_access));
  end set_name;

  function set_alias
    (port  : jack_types.port_t;
     alias : string) return jack_types.integer_t
  is
    c_alias : aliased c.char_array := c.to_c (alias);
  begin
    return cbinds.set_alias (port, cs.to_chars_ptr (c_alias'unchecked_access));
  end set_alias;

  function unset_alias
    (port  : jack_types.port_t;
     alias : string) return jack_types.integer_t
  is
    c_alias : aliased c.char_array := c.to_c (alias);
  begin
    return cbinds.unset_alias (port, cs.to_chars_ptr (c_alias'unchecked_access));
  end unset_alias;

  function request_monitor
    (port   : jack_types.port_t;
     enable : boolean) return jack_types.integer_t is
  begin
    if enable then
      return cbinds.request_monitor (port, 1);
    else
      return cbinds.request_monitor (port, 0);
    end if;
  end request_monitor;

  function request_monitor_by_name
    (port   : jack_types.port_t;
     name   : string;
     enable : boolean) return jack_types.integer_t
  is
    c_name : aliased c.char_array := c.to_c (name);
  begin
    if enable then
      return cbinds.request_monitor_by_name
        (port, cs.to_chars_ptr (c_name'unchecked_access), 1);
    else
      return cbinds.request_monitor_by_name
        (port, cs.to_chars_ptr (c_name'unchecked_access), 0);
    end if;
  end request_monitor_by_name;

  function ensure_monitor
    (port   : jack_types.port_t;
     enable : boolean) return jack_types.integer_t is
  begin
    if enable then
      return cbinds.ensure_monitor (port, 1);
    else
      return cbinds.ensure_monitor (port, 0);
    end if;
  end ensure_monitor;

  function monitoring (port : jack_types.port_t) return boolean is
  begin
    return cbinds.monitoring (port) = 1;
  end monitoring;

  function connect
    (client      : jack_types.client_t;
     source      : string;
     destination : string) return jack_types.integer_t
  is
    c_src : aliased c.char_array := c.to_c (source);
    c_dst : aliased c.char_array := c.to_c (destination);
  begin
    return cbinds.connect
      (client      => client,
       source      => cs.to_chars_ptr (c_src'unchecked_access),
       destination => cs.to_chars_ptr (c_dst'unchecked_access));
  end connect;

  function disconnect
    (client      : jack_types.client_t;
     source      : string;
     destination : string) return jack_types.integer_t
  is
    c_src : aliased c.char_array := c.to_c (source);
    c_dst : aliased c.char_array := c.to_c (destination);
  begin
    return cbinds.disconnect
      (client      => client,
       source      => cs.to_chars_ptr (c_src'unchecked_access),
       destination => cs.to_chars_ptr (c_dst'unchecked_access));
  end disconnect;

  function disconnect
    (client : jack_types.client_t;
     port   : jack_types.port_t) return jack_types.integer_t is
  begin
    return cbinds.port_disconnect (client, port);
  end disconnect;

  function by_name
    (client : jack_types.client_t;
     name   : string) return jack_types.port_t
  is
    c_name : aliased c.char_array := c.to_c (name);
  begin
    return cbinds.by_name (client, cs.to_chars_ptr (c_name'unchecked_access));
  end by_name;

end jack.port;
