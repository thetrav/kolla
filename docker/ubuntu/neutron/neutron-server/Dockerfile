FROM %%KOLLA_NAMESPACE%%/%%KOLLA_PREFIX%%neutron-base
MAINTAINER Kolla Project (https://launchpad.net/kolla)

#Install required packages
RUN apt-get install -y neutron-server neutron-plugin-ml2 python-neutronclient mariadb-client 

VOLUME /var/lib/neutron

ADD ./start.sh /start.sh
ADD ./check.sh /check.sh

EXPOSE 9696

CMD ["/start.sh"]
