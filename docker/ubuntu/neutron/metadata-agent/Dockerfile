FROM %%KOLLA_NAMESPACE%%/%%KOLLA_PREFIX%%neutron-base
MAINTAINER Kolla Project (https://launchpad.net/kolla)

# Install required packages
RUN apt-get install -y neutron-metadata-agent python-mysqldb

# Add required scripts
ADD ./start.sh /start.sh
ADD ./check.sh /check.sh

# Configure and run the service
CMD ["/start.sh"]
