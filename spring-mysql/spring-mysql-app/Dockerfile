FROM ubuntu:xenial

RUN apt-get update && \
    apt-get install -y \
        default-jdk \
        git && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists

RUN cd /root && \
    git clone https://github.com/spring-guides/gs-accessing-data-mysql.git && \
    cd gs-accessing-data-mysql && \
    git checkout c2f11f169d6678697d20fc5b4c7c0a019b7804b1 && \
    cd complete && \
    ./mvnw clean package

# Keeping max heap size to 2GB, as it seems sufficient to run the tests
CMD ["java", "-Xmx256m", "-Dspring.config.location=/root/gs-accessing-data-mysql/complete/src/main/resources/application.properties", "-jar", "/root/gs-accessing-data-mysql/complete/target/gs-mysql-data-0.1.0.jar"]
