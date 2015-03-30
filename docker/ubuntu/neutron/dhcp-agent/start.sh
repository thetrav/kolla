#!/bin/bash

set -e

. /opt/kolla/config-neutron.sh

#TODO: default these to false
: ${VERBOSE_LOGGING:=True}
: ${DEBUG_LOGGING:=True}

#crudini is creating multiple DEFAULT blocks >_<
# Configure dhcp_agent.ini
 echo "verbose=${VERBOSE_LOGGING}" >> /etc/neutron/dhcp_agent.ini
 echo "debug=${DEBUG_LOGGING}" >> /etc/neutron/dhcp_agent.ini
 echo "interface_driver=neutron.agent.linux.interface.OVSInterfaceDriver" >> /etc/neutron/dhcp_agent.ini
 echo "dhcp_driver=neutron.agent.linux.dhcp.Dnsmasq" >> /etc/neutron/dhcp_agent.ini
 echo "use_namespaces=True" >> /etc/neutron/dhcp_agent.ini
 echo "dhcp_delete_namespaces=True" >> /etc/neutron/dhcp_agent.ini
 echo "dnsmasq_config_file=/etc/neutron/dnsmasq-neutron.conf" >> /etc/neutron/dhcp_agent.ini

# Start DHCP Agent
exec /usr/bin/neutron-dhcp-agent --config-file=/etc/neutron/neutron.conf --config-file=/etc/neutron/dhcp_agent.ini --log-file=/var/log/neutron/dhcp-agent.log
