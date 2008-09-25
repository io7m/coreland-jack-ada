-- auto generated, do not edit

with ada.text_io;
with ada.command_line;

with jack;
with jack.transport;
with jack.types;

procedure ada_size is
  package io renames ada.text_io;
  package cmdline renames ada.command_line;

  -- generic types
  type generic_t is new integer;

  -- package instantiations
  package gen_jack_transport is new jack.transport
    (user_data_t => generic_t);
  package gen_jack_types is new jack.types
    (user_data_t => generic_t);

  -- type names
  jack_transport_position_bits_t : aliased string := "jack.transport.position_bits_t";
  jack_transport_position_t : aliased string := "jack.transport.position_t";
  jack_transport_state_t : aliased string := "jack.transport.state_t";
  jack_transport_sync_callback_t : aliased string := "jack.transport.sync_callback_t";
  jack_transport_timebase_callback_t : aliased string := "jack.transport.timebase_callback_t";
  jack_transport_unique_t : aliased string := "jack.transport.unique_t";
  jack_types_buffer_size_callback_t : aliased string := "jack.types.buffer_size_callback_t";
  jack_types_client_register_callback_t : aliased string := "jack.types.client_register_callback_t";
  jack_types_client_t : aliased string := "jack.types.client_t";
  jack_types_freewheel_callback_t : aliased string := "jack.types.freewheel_callback_t";
  jack_types_graph_order_callback_t : aliased string := "jack.types.graph_order_callback_t";
  jack_types_init_callback_t : aliased string := "jack.types.init_callback_t";
  jack_types_int_client_t : aliased string := "jack.types.int_client_t";
  jack_types_num_frames_t : aliased string := "jack.types.num_frames_t";
  jack_types_options_t : aliased string := "jack.types.options_t";
  jack_types_port_connect_callback_t : aliased string := "jack.types.port_connect_callback_t";
  jack_types_port_flags_t : aliased string := "jack.types.port_flags_t";
  jack_types_port_id_t : aliased string := "jack.types.port_id_t";
  jack_types_port_register_callback_t : aliased string := "jack.types.port_register_callback_t";
  jack_types_port_t : aliased string := "jack.types.port_t";
  jack_types_process_callback_t : aliased string := "jack.types.process_callback_t";
  jack_types_sample_rate_callback_t : aliased string := "jack.types.sample_rate_callback_t";
  jack_types_sample_t : aliased string := "jack.types.sample_t";
  jack_types_shm_size_t : aliased string := "jack.types.shm_size_t";
  jack_types_status_t : aliased string := "jack.types.status_t";
  jack_types_time_t : aliased string := "jack.types.time_t";
  jack_types_xrun_callback_t : aliased string := "jack.types.xrun_callback_t";

  type type_t is record
    name : access string;
    size : natural;
  end record;
  type type_lookup_t is array (natural range <>) of type_t;

  types : aliased constant type_lookup_t := (
    (jack_transport_position_bits_t'access, gen_jack_transport.position_bits_t'size),
    (jack_transport_position_t'access, gen_jack_transport.position_t'size),
    (jack_transport_state_t'access, gen_jack_transport.state_t'size),
    (jack_transport_sync_callback_t'access, gen_jack_transport.sync_callback_t'size),
    (jack_transport_timebase_callback_t'access, gen_jack_transport.timebase_callback_t'size),
    (jack_transport_unique_t'access, gen_jack_transport.unique_t'size),
    (jack_types_buffer_size_callback_t'access, gen_jack_types.buffer_size_callback_t'size),
    (jack_types_client_register_callback_t'access, gen_jack_types.client_register_callback_t'size),
    (jack_types_client_t'access, gen_jack_types.client_t'size),
    (jack_types_freewheel_callback_t'access, gen_jack_types.freewheel_callback_t'size),
    (jack_types_graph_order_callback_t'access, gen_jack_types.graph_order_callback_t'size),
    (jack_types_init_callback_t'access, gen_jack_types.init_callback_t'size),
    (jack_types_int_client_t'access, gen_jack_types.int_client_t'size),
    (jack_types_num_frames_t'access, gen_jack_types.num_frames_t'size),
    (jack_types_options_t'access, gen_jack_types.options_t'size),
    (jack_types_port_connect_callback_t'access, gen_jack_types.port_connect_callback_t'size),
    (jack_types_port_flags_t'access, gen_jack_types.port_flags_t'size),
    (jack_types_port_id_t'access, gen_jack_types.port_id_t'size),
    (jack_types_port_register_callback_t'access, gen_jack_types.port_register_callback_t'size),
    (jack_types_port_t'access, gen_jack_types.port_t'size),
    (jack_types_process_callback_t'access, gen_jack_types.process_callback_t'size),
    (jack_types_sample_rate_callback_t'access, gen_jack_types.sample_rate_callback_t'size),
    (jack_types_sample_t'access, gen_jack_types.sample_t'size),
    (jack_types_shm_size_t'access, gen_jack_types.shm_size_t'size),
    (jack_types_status_t'access, gen_jack_types.status_t'size),
    (jack_types_time_t'access, gen_jack_types.time_t'size),
    (jack_types_xrun_callback_t'access, gen_jack_types.xrun_callback_t'size)
  );

  procedure find (name : string) is
  begin
    for index in types'range loop
      if types (index).name.all = name then
        io.put_line (natural'image (types (index).size));
        return;
      end if;
    end loop;
    raise program_error with "fatal: unknown ada type";
  end find;

begin
  if cmdline.argument_count /= 1 then
    raise program_error with "fatal: incorrect number of args";
  end if;
  find (cmdline.argument (1));
end ada_size;
