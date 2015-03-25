#!/bin/sh

sed -i s/KEYSTONE_PUBLIC_SERVICE_HOST/$KEYSTONE_PUBLIC_SERVICE_HOST/g "/etc/openstack-dashboard/local_settings.py"

/usr/sbin/apache2ctl -DFOREGROUND