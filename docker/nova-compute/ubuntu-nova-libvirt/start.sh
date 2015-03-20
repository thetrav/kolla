#!/bin/bash

set -e

cfg=/etc/libvirt/libvirtd.conf

crudini --set $cfg DEFAULT listen_tls 0
crudini --set $cfg DEFAULT listen_tcp 1
crudini --set $cfg DEFAULT tls_port "16514"
crudini --set $cfg DEFAULT tcp_port "16509"
crudini --set $cfg DEFAULT auth_tcp "none"

/usr/sbin/libvirtd --listen