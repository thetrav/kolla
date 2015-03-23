#!/bin/bash

set -e

cfg=/etc/libvirt/libvirtd.conf

echo 'listen_tls=0' >> $cfg
echo 'listen_tcp=1' >> $cfg
echo 'tls_port="16514"' >> $cfg
echo 'tcp_port="16509"' >> $cfg
echo 'auth_tcp="none"' >> $cfg

/usr/sbin/libvirtd --listen