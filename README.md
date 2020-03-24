# ISCReports
JReport Server connected to InterSystems IRIS
# Containers
* **iris**: IRIS Community Edition
* **jrserver**: Centos + JDK + JReports Server

## Requirements
* Download any `JDK 8` from [Java downloads](https://www.oracle.com/java/technologies/javase-jdk8-downloads.html) and copy to `JRServer/OJDK/` sub-directory.
* Add `JReport Server installer` **i.e.** _jrserver-15.5-b201808021506-linux.bin_ [JReport downloads](https://www.jinfonet.com/product/download-jreport/) to `JRServer/Binaries`
* Add your specific _User & Password_ key information to the  `USER_KEY` & `USER_PASSWORD` properties of the `JRServer/Binaries/ServerInstall_iris.properties` file

## How to run
```
docker-compose up -d
```
In case you need to rebuild the images after the first time up (and first time built). There needs to be build first and up after building
```
docker-compose build --no-cache
docker-compose up -d
```

## How to access
...once the containers are up
### IRIS access
[IRIS Portal | http://localhost:52773/csp/sys/UtilHome.csp](http://localhost:52773/csp/sys/UtilHome.csp)
```
Default access:
Username: _System
Password: SYS
```


### JReport Server access
[JReport Server Console Portal | http://localhost:8888](http://localhost:8888)
```
Default access:
Username: admin
Password: admin
```