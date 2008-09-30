with interfaces.c;

package body jack.server is
  package c renames interfaces.c;

  use type c.int;

  package cbinds is
    function is_realtime (client : jack_types.client_t) return c.int;
    pragma import (c, is_realtime, "jack_is_realtime");
  end cbinds;

  function is_realtime (client : jack_types.client_t) return boolean is
  begin
    return cbinds.is_realtime (client) = 1;
  end is_realtime;

end jack.server;
