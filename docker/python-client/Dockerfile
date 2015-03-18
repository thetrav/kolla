FROM %%KOLLA_NAMESPACE%%/%%KOLLA_PREFIX%%base
MAINTAINER Kolla Project (https://launchpad.net/kolla)

#Install required packages
RUN yum install -y @development-tools python-devel python-pip\
    ; yum clean all

RUN pip install python-openstackclient

ADD entrypoint.sh /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]

CMD "/bin/bash"