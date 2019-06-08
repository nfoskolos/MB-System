#!/bin/sh

# There is no way to make clang's "argument unused" warning fatal.  So when
# configure checks for supported flags, it runs $CC, $CXX, $LD via this
# wrapper.
#
# Ideally the search string would also include 'clang: ' but this output might
# depend on clang's argv[0].

if out=`"$@" 2>&1`; then
  echo "$out"
  if echo "$out" | grep 'warning: argument unused' >/dev/null; then
    echo "$0: found clang warning"
    exit 1
  else
    exit 0
  fi
else
  code=$?
  echo "$out"
  exit $code
fi

