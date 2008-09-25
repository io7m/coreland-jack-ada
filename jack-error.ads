package jack.error is

  type error_callback_t is access procedure
    (message : string);

  procedure set_error_function
    (callback : error_callback_t);
  pragma inline (set_error_function);

end jack.error;
