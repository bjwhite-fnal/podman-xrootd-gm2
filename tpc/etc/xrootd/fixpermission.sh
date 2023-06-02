#!/bin/sh

cat | while read file; do
  dir=$(dirname $file)
  for i in $(seq 0 9); do
    base=$(basename $dir)
    [ "$base" == "rucio" -o "$base" == "fnal" -o "$base" == "/" ] && break
    chmod g-w,g+rxs $dir >/dev/null 2>&1
    dir=$(dirname $dir)
  done
done
