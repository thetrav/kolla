FROM %%KOLLA_NAMESPACE%%/%%KOLLA_PREFIX%%neutron-base
MAINTAINER Kolla Project (https://launchpad.net/kolla)

#Install required packages
RUN apt-get install -y neutron-plugin-openvswitch-agent

ADD ./start.sh /start.sh

CMD ["/start.sh"]
