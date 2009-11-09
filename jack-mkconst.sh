#!/bin/sh

if [ $# -ne 1 ]
then
  echo "usage: const.dat" 1>&2
  exit 1
fi

OLD_IFS="${IFS}"
IFS="
"

longest=0

for line in `cat $1`
do
  LINES="${LINES} $line"
done

IFS="${OLD_IFS}"

for line in ${LINES}
do
  value=`./jack-enum "${line}"` || exit 1
  printf "  %-24s : constant := ${value};" "${line}" || exit 1
  echo
done

echo
