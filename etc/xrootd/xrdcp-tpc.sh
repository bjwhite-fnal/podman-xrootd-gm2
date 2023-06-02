#!/bin/sh

unset LD_PRELOAD
#export XRD_CPPARALLELCHUNKS=16
#export XRD_CPCHUNKSIZE=262144

set -- `getopt S: -S 1 $*`
while [ $# -gt 0 ]
do
  case $1 in
  -S)
      ((nstreams=$2-1))
      [ $nstreams -ge 1 ] && TCPstreamOpts="-S $nstreams"
      shift 2
      ;;
  --)
      shift
      break
      ;;
  esac
done

src=$1
dst=$2

xrdcp --server $TCPstreamOpts -f $src ${dst}
#xrdcp --server --parallel 2 -S 2 -f $src ${dst}
