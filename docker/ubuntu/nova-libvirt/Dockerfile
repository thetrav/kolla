FROM %%KOLLA_NAMESPACE%%/%%KOLLA_PREFIX%%base

RUN apt-get -y install nova-compute sysfsutils

RUN mkdir -p /var/lib/libvirt/images/

ADD start.sh /start.sh

EXPOSE 16509

CMD /start.sh