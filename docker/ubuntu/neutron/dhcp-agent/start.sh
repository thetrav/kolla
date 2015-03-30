#!/bin/bash

set -e

. /opt/kolla/config-neutron.sh

check_required_vars VERBOSE_LOGGING DEBUG_LOGGING

cfg=/etc/neutron/dhcp_agent.ini

# Configure dhcp_agent.ini
crudini --set $cfg \
        DEFAULT \
        verbose \
        "${VERBOSE_LOGGING}"
crudini --set $cfg \
        DEFAULT \
        debug \
        "${DEBUG_LOGGING}"
crudini --set $cfg \
        DEFAULT \
        interface_driver \
        "neutron.agent.linux.interface.OVSInterfaceDriver"
crudini --set $cfg \
        DEFAULT \
        dhcp_driver \
        "neutron.agent.linux.dhcp.Dnsmasq"
crudini --set $cfg \
        DEFAULT \
        use_namespaces \
        "True"
crudini --set $cfg \
        DEFAULT \
        hdcp_delete_namespaces \
        "True"
crudini --set $cfg \
        DEFAULT \
        dnsmasq_config_file \
        "/etc/neutron/dnsmasq-neutron.conf"


# Start DHCP Agent
exec /usr/bin/neutron-dhcp-agent
