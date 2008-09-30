generic 
  type user_data_t is private;

package jack is
  pragma pure (jack);

  -- stop 'unused type' compiler warnings.
  type unused is new user_data_t;
end jack;
