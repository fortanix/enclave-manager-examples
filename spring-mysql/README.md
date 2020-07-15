The Spring MySQL sample demonstrates a simple Java application written using
the Spring framework, that accesses a MySQL database. The original may be found
at https://spring.io/guides/gs/accessing-data-mysql/. The sample consists of
two containers, which are available on Docker Hub:

 * [The application](https://hub.docker.com/r/fortanix/spring-mysql-app/)
 * [The database](https://hub.docker.com/r/fortanix/spring-mysql-db/)

You can also choose to build the images from this repository:

 ```
 cd spring-mysql-app
 docker build -t <app-name> .

 cd ../spring-mysql-db
 docker build -t <db-name> .
```
Follow instructions [here](https://support.fortanix.com/hc/en-us/articles/360046217731-Using-Fortanix-Enclave-Manager-to-Build-an-Enclave-OS-Spring-Application) to build and deploy the application using Fortanix Enclave Manager.
