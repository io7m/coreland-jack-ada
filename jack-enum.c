#include <jack/jack.h>
#include <stdio.h>

struct enum_value_t {
  const char *name;
  unsigned long value;
};

static const struct enum_values[] = {
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
main (void)
{
  return 0;
}
