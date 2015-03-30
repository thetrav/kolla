#!/bin/bash

set -e

. /opt/kolla/config-neutron.sh

#TODO: default these to false
: ${VERBOSE_LOGGING:=True}
: ${DEBUG_LOGGING:=True}

check_required_vars BRIDGE_PHYSICAL_INTERFACE

cfg=/etc/neutron/metadata_agent.ini

# Configure metadata_agent.ini
crudini --set $cfg DEFAULT verbose "${VERBOSE_LOGGING}"

if [$(ovs-vsctl br-exists br-ex) -eq 0]; then
  echo "bridge already exists"
else
  echo "creating bridge"
fi

