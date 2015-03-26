FROM %%KOLLA_NAMESPACE%%/%%KOLLA_PREFIX%%neutron-base
MAINTAINER Kolla Project (https://launchpad.net/kolla)

#Install required packages
RUN apt-get install -y neutron-server neutron-plugin-ml2 python-neutronclient mariadb-client python-mysqldb

#crux is made for fedora, PITA to get it onto ubuntu
RUN apt-get install -y git build-essential python-dev python-pip

RUN pip install python-keystoneclient>=0.9.0
RUN pip install cliff>1.4.3
RUN pip install -e git+https://github.com/larsks/crux.git#egg=crux-dev

VOLUME /var/lib/neutron

ADD ./start.sh /start.sh
ADD ./check.sh /check.sh

EXPOSE 9696

CMD ["/start.sh"]
