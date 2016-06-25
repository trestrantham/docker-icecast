FROM ubuntu:trusty

MAINTAINER Tres Trantham <tres@trestrantham.com>

ENV DEBIAN_FRONTEND noninteractive

RUN apt-get -qq -y update && \
    apt-get -qq -y install icecast2 python-setuptools && \
    apt-get clean

RUN easy_install supervisor && \
    easy_install supervisor-stdout

COPY "supervisord.conf" "/usr/share/icecast2/supervisord.conf"
COPY "icecast.xml" "/usr/share/icecast2/icecast.xml"

CMD ["/start.sh"]
EXPOSE 8000
VOLUME ["/var/log/icecast2", "/usr/share/icecast2"]

ADD ./start.sh /start.sh
RUN chown -R icecast2 /usr/share/icecast2
