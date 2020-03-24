# building from the InterSystems IRIS
FROM store/intersystems/iris-community:2019.4.0.379.0

# we need to use Root user to set up environment USER root
USER root

# copy all external dependencies, you can use apt-get here 

# copy in application code and build class 
#RUN mkdir -p /opt/iscreports/install
#COPY install /opt/iscreports/install
RUN mkdir -p /opt/iscreports
RUN mkdir -p /opt/iscreports/db
RUN mkdir -p /opt/iscreports/app
COPY irissession.sh /

# change permissions to IRIS user in directories
RUN chown ${ISC_PACKAGE_MGRUSER}:${ISC_PACKAGE_IRISGROUP} /irissession.sh
RUN chmod u+x /irissession.sh
RUN chown -R ${ISC_PACKAGE_MGRUSER}:${ISC_PACKAGE_IRISGROUP} /opt/iscreports
RUN chown ${ISC_PACKAGE_MGRUSER}:${ISC_PACKAGE_IRISGROUP} /opt/iscreports/db
RUN chown ${ISC_PACKAGE_MGRUSER}:${ISC_PACKAGE_IRISGROUP} /opt/iscreports/app


WORKDIR /opt/iscreports

# Change back to IRIS user 
USER irisowner
COPY . app
SHELL [ "/irissession.sh" ]

# Configure the application 
RUN \
  # iscreports installation
  do $SYSTEM.OBJ.Load("/opt/iscreports/app/src/ISCREP/Installer.cls", "ck") \
  set vars("Namespace")="ISCREP" \
  set vars("CreateNamespace")="no" \
  set vars("BasePath")="/opt/iscreports/app" \
  set vars("DataDBPath")="/opt/iscreports/db/iscreports/data" \
  set vars("CodeDBPath")="/opt/iscreports/db/iscreports/code" \
  set sc = ##class(ISCREP.Installer).RunWithParams(.vars) \
  # iris config
  zn "%SYS" \
  do ##class(SYS.Container).QuiesceForBundling() \
  do ##class(Security.Users).UnExpireUserPasswords("*") \
  halt

# bringing the standard shell back
SHELL ["/bin/bash", "-c"]
CMD [ "-l", "/usr/irissys/mgr/messages.log" ]