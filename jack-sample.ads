with interfaces.c;

package jack.sample is
  package c renames interfaces.c;

  -- Sample type (must match jack_default_audio_sample_t in jack/types.h)
  type type_t is new c.c_float;

end jack.sample;
