#!/bin/bash

set -e

. /opt/kolla/config-neutron.sh

#TODO: change these to default false 
: ${VERBOSE_LOGGING:=true}
: ${DEBUG_LOGGING:=true}

cfg=/etc/neutron/l3_agent.ini

# Configure l3_agent.ini
crudini --set $cfg DEFAULT verbose "${VERBOSE_LOGGING}"
crudini --set $cfg DEFAULT debug "${DEBUG_LOGGING}"
crudini --set $cfg DEFAULT interface_driver "neutron.agent.linux.interface.OVSInterfaceDriver"
crudini --set $cfg DEFAULT use_namespaces "True"
crudini --set $cfg DEFAULT external_network_bridge "br-ex"
crudini --set $cfg DEFAULT router_delete_namespaces "True"

#fix some missing config file related crash
mkdir -p /usr/share/neutron
touch /usr/share/neutron/neutron-dist.conf

# Start L3 Agent
exec /usr/bin/neutron-l3-agent --config-file /usr/share/neutron/neutron-dist.conf --config-file /etc/neutron/neutron.conf --config-file /etc/neutron/l3_agent.ini --config-file /etc/neutron/fwaas_driver.ini
