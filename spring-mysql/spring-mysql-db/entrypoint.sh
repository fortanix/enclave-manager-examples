#!/bin/bash

set -exo pipefail

# For the E-Wallet sample, we provide certs either from cert-manager (non-SGX)
# or Enclave Manager (SGX). This is here to make manual testing easier.
if [ ! -f /etc/mysql/server-cert.pem ]; then
	# Create CA certificate
	openssl genrsa -out /etc/mysql/ca-key.pem 2048
	openssl req -new -x509 -sha256 -days 365  -key /etc/mysql/ca-key.pem -out /etc/mysql/cacert.pem  -subj "/O=TestCA/CN=mysql"
	# Create server key and csr
	openssl req -newkey rsa:2048 -days 365 -nodes -keyout /etc/mysql/server-key.pem -out /etc/mysql/server-req.pem  -subj "/O=Test/CN=mysql"
	# Create server certificate from above CA
	openssl x509 -req -in /etc/mysql/server-req.pem -days 365 -CA /etc/mysql/cacert.pem  -CAkey /etc/mysql/ca-key.pem -set_serial 01 -out /etc/mysql/server-cert.pem -sha256
fi

/usr/sbin/mysqld -uroot --innodb_use_native_aio=0 --datadir=/var/lib/_mysql --pid-file=/run/mysqld/mysqld.pid --log-bin &
pid=$!

mysql=( mysql --protocol=tcp -uroot -hlocalhost --password=password --ssl )

for i in {30..0}; do
	if echo 'SELECT 1' | "${mysql[@]}" &> /dev/null; then
		break
	fi
	echo 'MySQL init process in progress...'
	sleep 1
done
if [ "$i" = 0 ]; then
	echo >&2 'MySQL init process failed.'
	exit 1
fi

if ! kill -s TERM "$pid" || ! wait "$pid"; then
	echo >&2 'MySQL init process failed.'
	exit 1
fi

/usr/sbin/mysqld -uroot --innodb_use_native_aio=0 --datadir=/var/lib/_mysql --pid-file=/run/mysqld/mysqld.pid --log-bin
