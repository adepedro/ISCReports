FROM centos:latest

#ARG INSTALL_PACKAGE=jrserver-15.5-b201808021506-linux.bin
#ARG INSTALL_PROPERTIES=ServerInstall_iris.properties

USER root

# Copy IRIS DB Drivers & JReport installer
COPY Patch/Drivers /opt/JReport/Drivers
# Copy installer & properties to /tmp
# COPY Binaries /tmp
ADD Binaries/*.bin /tmp/jrserver-installer.bin
ADD Binaries/ServerInstall_iris.properties /tmp
# Copy JDK installer to /tmp
ADD OJDK/jdk* /tmp/jdk.rpm

# RUN JDK RPM
RUN yum -y install /tmp/jdk.rpm
RUN rm -f /tmp/jdk.rpm
RUN yum clean all

# RUN JReport Installer
#RUN /tmp/$INSTALL_PACKAGE -i silent -f $INSTALL_PROPERTIES
RUN /tmp/jrserver-installer.bin -i silent -f ServerInstall_iris.properties

# Copy patches after install
COPY Patch/JIP /opt/JReport/Server/lib
COPY Patch/bin /opt/JReport/Server/bin

RUN chmod u+x /opt/JReport/Server/bin/JRServer.sh

ENTRYPOINT ["/opt/JReport/Server/bin/JRServer.sh"]

EXPOSE 8888
EXPOSE 59995
EXPOSE 59999
