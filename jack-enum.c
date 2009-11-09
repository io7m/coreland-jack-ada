#include <jack/jack.h>
#include <stdio.h>
#include <string.h>

struct enum_value_t {
  const char *name;
  unsigned long value;
};

static const struct enum_value_t enum_values[] = {
  { "JackPortIsInput",    (unsigned long) JackPortIsInput },
  { "JackPortIsOutput",   (unsigned long) JackPortIsOutput },
  { "JackPortIsPhysical", (unsigned long) JackPortIsPhysical },
  { "JackPortCanMonitor", (unsigned long) JackPortCanMonitor },
  { "JackPortIsTerminal", (unsigned long) JackPortIsTerminal },
  { "JackFailure",        (unsigned long) JackFailure },
  { "JackInvalidOption",  (unsigned long) JackInvalidOption },
  { "JackNameNotUnique",  (unsigned long) JackNameNotUnique },
  { "JackServerStarted",  (unsigned long) JackServerStarted },
  { "JackServerFailed",   (unsigned long) JackServerFailed },
  { "JackServerError",    (unsigned long) JackServerError },
  { "JackNoSuchClient",   (unsigned long) JackNoSuchClient },
  { "JackLoadFailure",    (unsigned long) JackLoadFailure },
  { "JackInitFailure",    (unsigned long) JackInitFailure },
  { "JackShmFailure",     (unsigned long) JackShmFailure },
  { "JackVersionError",   (unsigned long) JackVersionError },
};

int
main (int argc, char *argv[])
{
  unsigned int index;

  if (argc < 2) {
    fprintf (stderr, "usage: enum_value\n");
    return 1;
  }

  for (index = 0; index < sizeof (enum_values) / sizeof (enum_values [0]); ++index) {
    if (strcmp (enum_values [index].name, argv [1]) == 0) {
      printf ("%lu\n", enum_values [index].value);
      return 0;
    }
  }

  fprintf (stderr, "fatal: unknown enum value\n");
  return 1;
}
