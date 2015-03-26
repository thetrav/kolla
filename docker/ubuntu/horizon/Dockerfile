FROM %%KOLLA_NAMESPACE%%/%%KOLLA_PREFIX%%base

RUN apt-get -y install openstack-dashboard apache2 libapache2-mod-wsgi memcached python-memcache

ADD ./local_settings.py /etc/openstack-dashboard/local_settings.py

ADD ./start.sh /start.sh

EXPOSE 80

CMD "/start.sh"