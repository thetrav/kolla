#!/bin/sh

: ${LOG_LEVEL:=INFO}

sed -i s/KEYSTONE_PUBLIC_SERVICE_HOST/$KEYSTONE_PORT_5000_TCP_ADDR/g "/etc/openstack-dashboard/local_settings.py"
sed -i s/LOG_LEVEL/$LOG_LEVEL/g "/etc/openstack-dashboard/local_settings.py"


/usr/sbin/apache2ctl -DFOREGROUND