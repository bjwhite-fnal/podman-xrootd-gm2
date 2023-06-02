#!/bin/python
import sys, zlib

if len(sys.argv) == 1:
  fn = "-"
  f = sys.stdin
else:  
  fn = sys.argv[1]
  f = open(fn, "r")
adler = 1
while True:
  buf = f.read(1024*32)
  if buf == "" :
    break
  else:
    adler = zlib.adler32(buf, adler)
f.close()
if adler < 0:
  adler = adler + 2 ** 32
print("%08x %s" % (adler, fn))
