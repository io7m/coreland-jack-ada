#!/bin/sh
# auto generated, do not edit

size_ada=`./ada_size "jack.types.buffer_size_callback_t"`
if [ $? -ne 0 ]; then exit 2; fi
size_c=`./c_size "JackBufferSizeCallback"`
if [ $? -ne 0 ]; then exit 2; fi

printf "%8d %8d %s -> %s\n" "${size_ada}" "${size_c}" "jack.types.buffer_size_callback_t" "JackBufferSizeCallback"

if [ ${size_ada} -ne ${size_c} ]
then
  echo "error: size mismatch" 1>&2
  exit 1
fi
