#!/bin/bash
PATCH_LEVEL=JIP_S_1550_ga_201909181413.jar
. "`dirname "$0"`/setenv.sh"
CLASSPATH=$REPORTHOME/lib/$PATCH_LEVEL:$REPORTHOME/derby/lib/*:$REPORTHOME/resources/common:$REPORTHOME/lib/plugin.jar:$REPORTHOME/lib/JREngine.jar:$REPORTHOME/lib/JRESServlets.jar:$REPORTHOME/lib/JRStructuredEngine.jar:$REPORTHOME/lib/JRStructuredClient.jar:$REPORTHOME/lib/JREntServer.jar:$REPORTHOME/lib/JRWebDesign.jar:$REPORTHOME/lib/*:$ADDCLASSPATH
cd "$REPORTHOME/bin"
$JAVAHOME/bin/java -classpath "$CLASSPATH" -Dinstall.root="$REPORTHOME/" -Djava.net.preferIPv4Stack=true -Djreport.url.encoding=UTF-8 -Xms512m -Xmx1400m -Dreporthome="$REPORTHOME"  -Dadmin.port.enabled="false" jet.server.JREntServer "$@"
