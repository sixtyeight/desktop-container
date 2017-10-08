FROM consol/centos-xfce-vnc:1.2.1

## Use root to install additional software
USER 0

## Install 7zip, gedit, wget, OpenJDK8
RUN yum -y install p7zip p7zip-plugins install gedit wget java-1.8.0-openjdk java-1.8.0-openjdk-devel \
    && yum clean all

## Install Eclipse Oxygen 1
RUN wget http://ftp.halifax.rwth-aachen.de/eclipse//technology/epp/downloads/release/oxygen/1/eclipse-jee-oxygen-1-linux-gtk-x86_64.tar.gz -O /tmp/eclipse.tar.gz -q && \
    echo 'Installing eclipse' && \
    tar -xf /tmp/eclipse.tar.gz -C /opt && \
    rm /tmp/eclipse.tar.gz

## Add Desktop launchers
COPY *.desktop /headless/Desktop/ 

## Add Camunda Modeler
COPY camunda-modeler-1.10.0-linux-x64.tar.gz /tmp/camunda-modeler.tar.gz
RUN tar -xf /tmp/camunda-modeler.tar.gz -C /opt && rm /tmp/camunda-modeler.tar.gz

## Add SoapUI
COPY SoapUI-5.3.0-linux-bin.tar.gz /tmp/soap-ui.tar.gz
RUN tar -xf /tmp/soap-ui.tar.gz -C /opt && rm /tmp/soap-ui.tar.gz

## Add SquirrelSQL Client
COPY squirrelsql-3.8.0-optional.tar.gz  /tmp/squirrelsql.tar.gz
RUN tar -xf /tmp/squirrelsql.tar.gz -C /opt && rm /tmp/squirrelsql.tar.gz && chmod ugo+x /opt/squirrelsql-3.8.0-optional/squirrel-sql.sh

## Add OpenShift Commandline client
COPY oc /usr/local/bin

## Add RTC Eclipse plugin if available
COPY install-rtc-client.sh RTC-*.zip /opt/
RUN /opt/install-rtc-client.sh

## Dirty hack to remove the Desktop background 
RUN rm /headless/.config/bg_sakuli.png

## switch back to default user
USER 1984
