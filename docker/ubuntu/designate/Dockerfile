FROM %%KOLLA_NAMESPACE%%/%%KOLLA_PREFIX%%base

RUN apt-get -y install python-pip git build-dep python-lxml libmysqlclient-dev

RUN pip install mysql-python

WORKDIR /var/lib

RUN git clone https://github.com/openstack/designate.git

WORKDIR /var/lib/designate

RUN git checkout stable/juno

RUN pip install -r requirements.txt -r test-requirements.txt

RUN python setup.py develop

WORKDIR /var/lib/designate/etc/designate

RUN ls *.sample | while read f; do cp $f $(echo $f | sed "s/.sample$//g"); done

RUN mkdir /var/log/designate

ADD designate.conf /var/lib/designate/etc/designate/designate.conf

ADD ./start.sh /start.sh

EXPOSE 80

CMD "/start.sh"