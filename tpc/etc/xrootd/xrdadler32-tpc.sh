#!/bin/sh

me=$(readlink -f $0)
mydir=$(dirname $me)

t0=$(date +%s)

if [ $1 == "adler32" -o $1 == "md5" ]; then # note xrootd supports more than these two
  ckalgr=$1
  shift
else
  ckalgr="adler32"
fi

osslocalroot=/sdf/group/rubin/sandbox/rses
if [ $ckalgr == "adler32" ]; then
  xrdadler32 $osslocalroot/$1 | awk '{print $1}'
  #python2.7 $mydir/adler32.py $osslocalroot/$1 | awk '{print $1}'
  #$mydir/adler32.exe $osslocalroot/$1
else
  md5sum $osslocalroot/$1 | awk '{print $1}'
fi
rc=$?

#t1=$(date +%s)
#((dt = $t1 - $t0))
#echo $rc $dt >> /tmp/adler32.log

exit $rc
#>&2 echo "adler32: " $1
#echo `date +'%y%m%d %T'` 'adler32' $1 >> /tmp/adler32.log
