#!/bin/bash

sed -i -e "s/localhost/$DB_URL/" /root/gs-accessing-data-mysql/complete/src/main/resources/application.properties

java -Xmx256m -Dspring.config.location=/root/gs-accessing-data-mysql/complete/src/main/resources/application.properties -jar /root/gs-accessing-data-mysql/complete/target/gs-mysql-data-0.1.0.jar
