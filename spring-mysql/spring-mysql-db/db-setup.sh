#!/bin/bash

set -e

mysqld -uroot --datadir=/var/lib/_mysql --pid-file=/run/mysqld/mysqld.pid &

sleep 5

mysql -u root --protocol tcp < /root/schema.sql

mysql -u root --protocol tcp -e "grant all on *.* to 'root'@'%' identified by 'password' require ssl with grant option"
mysql -u root --protocol tcp -e "grant all on db_example.* to 'springuser'@'%' identified by 'ThePassword'"
mysql -u root --protocol tcp mysql -e "delete from user where Host != '%'"

mysqladmin shutdown
