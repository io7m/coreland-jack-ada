#include <assert.h>
#include <stdlib.h>

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
