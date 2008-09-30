/* auto generated, do not edit */

#include <jack/jack.h>

#include <stdio.h>
#include <string.h>
#include <stdlib.h>

struct {
  const char *type_name;
  unsigned int type_size;
} types[] = {
  { "jack_position_bits_t", sizeof (jack_position_bits_t) },
  { "jack_position_t", sizeof (jack_position_t) },
  { "jack_transport_state_t", sizeof (jack_transport_state_t) },
  { "JackSyncCallback", sizeof (JackSyncCallback) },
  { "JackTimebaseCallback", sizeof (JackTimebaseCallback) },
  { "jack_unique_t", sizeof (jack_unique_t) },
  { "JackBufferSizeCallback", sizeof (JackBufferSizeCallback) },
  { "JackClientRegistrationCallback", sizeof (JackClientRegistrationCallback) },
  { "jack_client_t *", sizeof (jack_client_t *) },
  { "JackFreewheelCallback", sizeof (JackFreewheelCallback) },
  { "JackGraphOrderCallback", sizeof (JackGraphOrderCallback) },
  { "JackThreadInitCallback", sizeof (JackThreadInitCallback) },
  { "jack_intclient_t", sizeof (jack_intclient_t) },
  { "jack_nframes_t", sizeof (jack_nframes_t) },
  { "jack_options_t", sizeof (jack_options_t) },
  { "JackPortConnectCallback", sizeof (JackPortConnectCallback) },
  { "enum JackPortFlags", sizeof (enum JackPortFlags) },
  { "jack_port_id_t", sizeof (jack_port_id_t) },
  { "JackPortRegistrationCallback", sizeof (JackPortRegistrationCallback) },
  { "jack_port_t *", sizeof (jack_port_t *) },
  { "JackProcessCallback", sizeof (JackProcessCallback) },
  { "JackSampleRateCallback", sizeof (JackSampleRateCallback) },
  { "jack_default_audio_sample_t", sizeof (jack_default_audio_sample_t) },
  { "jack_shmsize_t", sizeof (jack_shmsize_t) },
  { "jack_status_t", sizeof (jack_status_t) },
  { "jack_time_t", sizeof (jack_time_t) },
  { "JackXRunCallback", sizeof (JackXRunCallback) },
};
const unsigned int types_size = sizeof (types) / sizeof (types[0]);

void
find (const char *name)
{
  unsigned int pos;
  for (pos = 0; pos < types_size; ++pos) {
    if (strcmp (types[pos].type_name, name) == 0) {
      printf ("%u\n", types[pos].type_size * 8);
      return;
    }
  }
  fprintf (stderr, "fatal: unknown C type\n");
  exit (112);
}

int
main (int argc, char *argv[])
{
  if (argc != 2) exit (111);
  find (argv[1]);
  return 0;
}
