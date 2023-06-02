#!/bin/bash

RUN_DIR=/root/xrootd
X509_HOST_CERT_DIR=/etc/grid-security/gm2cornellsrv1.fnal.gov
X509_CA_CERT_DIR=/etc/grid-security/certificates
X509_VOMS_DIR=/etc/grid-security/vomsdir

podman run \
	--name gm2-cornell-xrootd \
	--detach \
	-v $X509_HOST_CERT_DIR:/etc/grid-security/xrd \
	-v $X509_CA_CERT_DIR:/etc/grid-security/certificates \
	-v $X509_VOMS_DIR:/etc/grid-security/vomsdir \
	-v $RUN_DIR/etc/xrootd:/etc/xrootd \
	-v $RUN_DIR/standalone:/standalone \
	-v /tmp/xrootd:/var/log/xrootd \
	-v /gm2data:/gm2data \
	-e XRD_LOGLEVEL='debug' \
	-p 1094:1094 \
	localhost/gm2-xrd-standalone
