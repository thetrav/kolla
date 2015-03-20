#!/bin/bash

set -e

cfg=/etc/nova/nova.conf
crudini -set $cfg DEFAULT rpc_backend "rabbit"
crudini -set $cfg DEFAULT rabbit_host "${RABBITMQ_SERVICE_HOST}"
crudini -set $cfg DEFAULT rabbit_password "${RABBIT_PASSWORD}"
crudini -set $cfg DEFAULT auth_strategy "keystone"

crudini -set $cfg keystone_authtoken auth_uri "http://${KEYSTONE_PUBLIC_SERVICE_HOST}:5000/v2.0"
crudini -set $cfg keystone_authtoken identity_uri "http://${KEYSTONE_PUBLIC_SERVICE_HOST}:35357"
crudini -set $cfg keystone_authtoken admin_tenant_name "admin"
crudini -set $cfg keystone_authtoken admin_user "${NOVA_KEYSTONE_USER}"
crudini -set $cfg keystone_authtoken admin_password "${NOVA_KEYSTONE_PASSWORD}"

crudini -set $cfg DEFAULT my_ip "${MANAGEMENT_IP}"

crudini -set $cfg DEFAULT vnc_enabled "True"
crudini -set $cfg DEFAULT vncserver_listen "0.0.0.0"
crudini -set $cfg DEFAULT vncserver_proxyclient_address "${MANAGEMENT_IP}"
crudini -set $cfg DEFAULT novncproxy_base_url "http://${NOVNC_IP}:6080/vnc_auto.html"

crudini -set $cfg glance host "${GLANCE_API_SERVICE_HOST}"

cfg=/etc/nova/nova-compute.conf
crudini -set $cfg libvirt connection_uri "qemu+tcp://${LIBVIRT_HOST}/system"

/usr/bin/nova-compute --config-file=/etc/nova/nova.conf --config-file=/etc/nova/nova-compute.conf
