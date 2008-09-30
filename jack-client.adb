with interfaces.c;
with interfaces.c.strings;

package body jack.client is
  package c renames interfaces.c;
  package cs renames interfaces.c.strings;

  package cbinds is
    function open
      (name    : cs.chars_ptr;
       options : jack_types.options_t;
       status  : jack_types.status_access_t) return jack_types.client_t;
    pragma import (c, open, "jack_client_open");

    function get_name (client : jack_types.client_t) return cs.chars_ptr;
    pragma import (c, get_name, "jack_get_client_name");

    function set_freewheel
      (client : jack_types.client_t;
       enable : jack_types.integer_t) return jack_types.integer_t;
    pragma import (c, set_freewheel, "jack_set_freewheel");
  end cbinds;

  function open
    (name    : string;
     options : jack_types.options_t;
     status  : jack_types.status_access_t) return jack_types.client_t
  is
    c_name : aliased c.char_array := c.to_c (name);
  begin
    return cbinds.open
      (name    => cs.to_chars_ptr (c_name'unchecked_access),
       options => options,
       status  => status);
  end open;

  function get_name (client : jack_types.client_t) return string is
  begin
    return cs.value (cbinds.get_name (client));
  end get_name;

  function set_freewheel
    (client : jack_types.client_t;
     enable : boolean) return jack_types.integer_t is
  begin
    if enable then
      return cbinds.set_freewheel (client, 1);
    else
      return cbinds.set_freewheel (client, 0);
    end if;
  end set_freewheel;

end jack.client;
