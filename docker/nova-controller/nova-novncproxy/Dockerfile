FROM %%KOLLA_NAMESPACE%%/%%KOLLA_PREFIX%%nova-base
MAINTAINER Kolla Project (https://launchpad.net/kolla)

RUN yum -y install openstack-nova-novncproxy && yum clean all

EXPOSE 6080

ADD ./start.sh /start.sh
CMD ["/start.sh"]
