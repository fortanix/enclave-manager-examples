FROM mariadb:10.3.11
MAINTAINER Fortanix, Inc. <info@fortanix.com>

# Update some packages with security vulnerabilities
RUN apt-get update && \
    apt-get -y install \
        libssl1.1 \
        perl && \
    apt-get clean && rm -rf /var/lib/apt/lists

RUN /usr/bin/mysql_install_db --datadir=/var/lib/_mysql

ADD entrypoint.sh /usr/local/bin/

ADD db-setup.sh schema.sql /root/
RUN /root/db-setup.sh

# /var/run isn't available; use /run instead
RUN sed -i 's/\/var\/run\//\/run\//'  /etc/mysql/my.cnf

RUN sed -i 's/^# ssl-\(cert\|key\|ca\)/ssl-\1/' /etc/mysql/my.cnf

ENTRYPOINT ["/usr/local/bin/entrypoint.sh"]
