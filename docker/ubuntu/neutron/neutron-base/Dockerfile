FROM %%KOLLA_NAMESPACE%%/%%KOLLA_PREFIX%%base
MAINTAINER Kolla Project (https://launchpad.net/kolla)

RUN apt-get -y install neutron-plugin-ml2

RUN mkdir -p /opt/kolla
COPY config-neutron.sh /opt/kolla/config-neutron.sh

