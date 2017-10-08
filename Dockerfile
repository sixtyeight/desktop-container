FROM consol/centos-xfce-vnc:1.2.1

## Use root to install additional software
USER 0

## Install wget, OpenJDK8
RUN yum -y install wget java-1.8.0-openjdk java-1.8.0-openjdk-devel \
    && yum clean all

## Install Eclipse Oxygen 1
RUN wget http://ftp.halifax.rwth-aachen.de/eclipse//technology/epp/downloads/release/oxygen/1/eclipse-jee-oxygen-1-linux-gtk-x86_64.tar.gz -O /tmp/eclipse.tar.gz -q && \
    echo 'Installing eclipse' && \
    tar -xf /tmp/eclipse.tar.gz -C /opt && \
    rm /tmp/eclipse.tar.gz

## Add Eclipse Desktop launcher
COPY eclipse.desktop /headless/Desktop/ 

## Remove Background the easy way
RUN rm /headless/.config/bg_sakuli.png

## switch back to default user
USER 1984
