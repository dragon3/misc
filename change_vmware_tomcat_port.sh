#!/bin/sh
#
# Change VMWare Server's Tomcat port.
#
# see: http://communities.vmware.com/thread/172606
#
VM_TOMCAT="/usr/lib/vmware/webAccess/tomcat/apache-tomcat-6.0.16"
sudo cp $VM_TOMCAT/conf/server.xml $VM_TOMCAT/conf/server.xml.orig
sudo perl -pi -e 's/port="8005"/port="8105"/' $VM_TOMCAT/conf/server.xml
sudo perl -pi -e 's/port="8009"/port="8109"/' $VM_TOMCAT/conf/server.xml

# restart webAccess
sudo kill -TERM `pidof webAccess`
