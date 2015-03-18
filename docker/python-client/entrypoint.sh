#!/bin/bash

export OS_AUTH_URL=http://$KEYSTONE_ENV_KEYSTONE_ADMIN_SERVICE_HOST:5000/v2.0

exec "$@"