#include <assert.h>
#include <stdlib.h>

#include <jack/jack.h>

/*
 * GCC GNAT 4.4.0 appears to miscompile Ada code calling functions with
 * variadic arguments, so a bridge is used here.
 */

jack_client_t *
jack_ada_client_open
  (const char *client_name, jack_options_t options, jack_status_t *status)
{
  return jack_client_open (client_name, options, status, NULL);
}

void
jack_ada_client_get_ports_free (char **names)
{
  unsigned int index = 0;

  assert (names != NULL);

  for (;;) {
    if (names [index] == NULL) break;
    free (names [index]);
    ++index;
  }
}
