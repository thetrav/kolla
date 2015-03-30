#!/bin/sh

set -e

. /opt/kolla/kolla-common.sh

: ${ADMIN_TENANT_NAME:=admin}
: ${NEUTRON_DB_NAME:=neutron}
: ${NEUTRON_DB_USER:=neutron}
: ${NEUTRON_KEYSTONE_USER:=neutron}
: ${KEYSTONE_AUTH_PROTOCOL:=http}
: ${RABBIT_HOST:=$RABBITMQ_SERVICE_HOST}
: ${RABBIT_USER:=guest}
: ${RABBIT_PASSWORD:=guest}
: ${VERBOSE_LOGGING:=true}
: ${DEBUG_LOGGING:=false}

check_required_vars NEUTRON_KEYSTONE_PASSWORD KEYSTONE_PUBLIC_SERVICE_HOST RABBITMQ_SERVICE_HOST

dump_vars

cat > /openrc <<EOF
export OS_AUTH_URL="http://${KEYSTONE_PUBLIC_SERVICE_HOST}:5000/v2.0"
export OS_USERNAME="${NEUTRON_KEYSTONE_USER}"
export OS_PASSWORD="${NEUTRON_KEYSTONE_PASSWORD}"
export OS_TENANT_NAME="${ADMIN_TENANT_NAME}"
EOF

core_cfg=/etc/neutron/neutron.conf
ml2_cfg=/etc/neutron/plugins/ml2/ml2_conf.ini

# Logging
crudini --set $core_cfg DEFAULT log_dir "/var/log/neutron"
crudini --set $core_cfg DEFAULT verbose "${VERBOSE_LOGGING}"
crudini --set $core_cfg DEFAULT debug "${DEBUG_LOGGING}"

# Rabbit
crudini --set $core_cfg DEFAULT rabbit_host "${RABBIT_HOST}"
crudini --set $core_cfg DEFAULT rabbit_userid "${RABBIT_USER}"
crudini --set $core_cfg DEFAULT rabbit_password "${RABBIT_PASSWORD}"

# Keystone
crudini --set $core_cfg DEFAULT auth_strategy "keystone"
crudini --set $core_cfg keystone_authtoken auth_protocol "${KEYSTONE_AUTH_PROTOCOL}"
crudini --set $core_cfg keystone_authtoken auth_host "${KEYSTONE_ADMIN_SERVICE_HOST}"
crudini --set $core_cfg keystone_authtoken auth_port "${KEYSTONE_ADMIN_SERVICE_PORT}"
crudini --set $core_cfg keystone_authtoken auth_uri "${KEYSTONE_AUTH_PROTOCOL}://${KEYSTONE_PUBLIC_SERVICE_HOST}:5000/"
crudini --set $core_cfg keystone_authtoken admin_tenant_name "${ADMIN_TENANT_NAME}"
crudini --set $core_cfg keystone_authtoken admin_user "${NEUTRON_KEYSTONE_USER}"
crudini --set $core_cfg keystone_authtoken admin_password "${NEUTRON_KEYSTONE_PASSWORD}"

# neutron.conf ml2 configuration
crudini --set $core_cfg DEFAULT core_plugin "ml2"
crudini --set $core_cfg DEFAULT service_plugins "router"
crudini --set $core_cfg DEFAULT allow_overlapping_ips "True"

# Configure ml2_conf.ini
crudini --set $ml2_cfg ml2 type_drivers "flat,gre"
crudini --set $ml2_cfg ml2 tenant_network_types "gre"
crudini --set $ml2_cfg ml2 mechanism_drivers "openvswitch"
crudini --set $ml2_cfg ml2_type_gre tunnel_id_ranges "1:1000"

crudini --set $ml2_cfg securitygroup enable_security_group "True"
crudini --set $ml2_cfg securitygroup enable_ipset "True"
crudini --set $ml2_cfg securitygroup firewall_driver "neutron.agent.linux.iptables_firewall.OVSHybridIptablesFirewallDriver"
 
crudini --set $ml2_cfg ovs local_ip "${TUNNEL_IP}"
crudini --set $ml2_cfg ovs enable_tunneling "True"
crudini --set $ml2_cfg ovs bridge_mappings "external:${EXTERNAL_BRIDGE_NAME}"
