with interfaces.c.strings;

package body jack.error is
  package cs renames interfaces.c.strings;

  package cbinds is
    type error_callback_t is access procedure (msg : cs.chars_ptr);
    pragma convention (c, error_callback_t);

    procedure set_error_function (callback : error_callback_t);
    pragma import (c, set_error_function, "jack_set_error_function");
  end cbinds;

  -- saved Ada callback
  saved_callback : error_callback_t;

  -- C function to call provided Ada callback
  procedure c_error_callback (msg : cs.chars_ptr);
  pragma convention (c, c_error_callback);
  procedure c_error_callback (msg : cs.chars_ptr) is
  begin
    saved_callback (cs.value (msg));
  end c_error_callback;

  procedure set_error_function (callback : error_callback_t) is
  begin
    saved_callback := callback;
    cbinds.set_error_function (c_error_callback'access);
  end set_error_function;

end jack.error;
