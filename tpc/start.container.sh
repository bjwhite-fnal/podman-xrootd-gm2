#!/bin/sh

op="run"
[ ! -z "$1" ] && op="shell"

me=$(readlink -f $0)
dir=$(dirname $me)

if [ -d /cvmfs/oasis.opensciencegrid.org ]; then
    x509_cert_dir=/cvmfs/oasis.opensciencegrid.org/mis/certificates
    x509_voms_dir=/cvmfs/oasis.opensciencegrid.org/mis/vodata/grid-security/vomsdir
    export X509_CERT_DIR=$x509_cert_dir
    export X509_VOMS_DIR=$x509_voms_dir
elif [ -d /afs/slac/package/vdt/vol7 ]; then
    x509_cert_dir=/afs/slac/package/vdt/vol7/certificates
    x509_voms_dir=/afs/slac/package/vdt/vol7/vomsdir
elif [ -d /sdf/sw/grid/etc/grid-security ]; then
    x509_cert_dir=/sdf/sw/grid/etc/grid-security/certificates
    x509_voms_dir=/sdf/sw/grid/etc/grid-security/vomsdir
else 
    x509_cert_dir=/etc/grid-security/certificates
    x509_voms_dir=/etc/grid-security/vomsdir
fi

#TMP=/scratch/yangw  # need 20GB+ space
TMP=/var/tmp  # need 20GB+ space
mkdir -p $TMP/xrootd/var/spool $TMP/xrootd/data
cd $TMP/xrootd/var/spool

kill $(cat $TMP/xrootd/var/run/xrootd.pid)
singularity $op -B /etc/grid-security/xrd-lsstsvc1:/etc/grid-security/xrd \
                -B $x509_cert_dir:/etc/grid-security/certificates \
                -B $x509_voms_dir:/etc/grid-security/vomsdir \
                -B $dir/etc/xrootd:/etc/xrootd \
                -B $dir/singularity/runscript:/.singularity.d/runscript \
                -B $TMP:/tmp \
                -B /sdf:/sdf \
                -H ${HOME}:/mnt \
            $dir/singularity/xrd.tpc.rpms.5.4.2-1.sif
#            $dir/singularity/xrd.tpc.rpms.2586893.70066fe7.sif
