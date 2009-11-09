#include <jack/jack.h>
#include <stdio.h>
#include <string.h>

struct enum_value_t {
  const char *name;
  unsigned long value;
};

static const struct enum_value_t enum_values[] = {
  { "JackFailure", (unsigned long) JackFailure },
  { "JackInitFailure", (unsigned long) JackInitFailure },
  { "JackInvalidOption", (unsigned long) JackInvalidOption },
  { "JackLoadFailure", (unsigned long) JackLoadFailure },
  { "JackLoadInit", (unsigned long) JackLoadInit },
  { "JackLoadName", (unsigned long) JackLoadName },
  { "JackNameNotUnique", (unsigned long) JackNameNotUnique },
  { "JackNoStartServer", (unsigned long) JackNoStartServer },
  { "JackNoSuchClient", (unsigned long) JackNoSuchClient },
  { "JackPortCanMonitor", (unsigned long) JackPortCanMonitor },
  { "JackPortIsInput", (unsigned long) JackPortIsInput },
  { "JackPortIsOutput", (unsigned long) JackPortIsOutput },
  { "JackPortIsPhysical", (unsigned long) JackPortIsPhysical },
  { "JackPortIsTerminal", (unsigned long) JackPortIsTerminal },
  { "JackServerError", (unsigned long) JackServerError },
  { "JackServerFailed", (unsigned long) JackServerFailed },
  { "JackServerName", (unsigned long) JackServerName },
  { "JackServerStarted", (unsigned long) JackServerStarted },
  { "JackShmFailure", (unsigned long) JackShmFailure },
  { "JackUseExactName", (unsigned long) JackUseExactName },
  { "JackVersionError", (unsigned long) JackVersionError },
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
