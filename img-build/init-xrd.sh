#!/bin/sh

echo "Changing ownership of XRootD server certificate/key to xroot:xrootd."
chown -R xrootd:xrootd /etc/grid-security/xrd
chown -R xrootd:xrootd /standalone
chown -R xrootd:xrootd /var/log/xrootd
echo "Completed ownership modification."
/usr/local/sbin/supervisord_startup.sh
