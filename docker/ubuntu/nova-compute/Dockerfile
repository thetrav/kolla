FROM %%KOLLA_NAMESPACE%%/%%KOLLA_PREFIX%%base

RUN apt-get -y install nova-compute sysfsutils

ADD start.sh /start.sh

CMD /start.sh