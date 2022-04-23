# based on https://github.com/mamohr/docker-centos-java
FROM centos:7
MAINTAINER Shukri Adams <shukri.adams@gmail.com>

ENV JAVA_VERSION 8u162
ENV BUILD_VERSION b12

# Note : this link is likely to expire, so find whatever path Oracle moved the latest JRE-8 
ENV DOWNLOAD_LINK "https://javadl.oracle.com/webapps/download/AutoDL?BundleId=246254_165374ff4ea84ef0bbd821706e29b123"

# Upgrading system
RUN yum -y update && \
    yum -y install wget && \
    wget --no-cookies --no-check-certificate --header "Cookie: gpw_e24=xxx; oraclelicense=accept-securebackup-cookie" "$DOWNLOAD_LINK" -O /tmp/jre-8-linux-x64.rpm && \
    yum -y install /tmp/jre-8-linux-x64.rpm && \
    rm -f /tmp/jre-8-linux-x64.rpm && \
    yum clean all

ENV JAVA_HOME /usr/java/latest

RUN \
    yum update -y && \
    yum install -y epel-release && \
    yum install -y net-tools python-setuptools hostname inotify-tools yum-utils && \
    yum clean all && \
    yum install -y python3-pip

RUN pip3 install supervisor

ENV FILE https://www.collab.net/sites/default/files/downloads/CollabNetSubversionEdge-5.2.4_linux-x86_64.tar.gz

RUN wget -q ${FILE} -O /tmp/csvn.tgz && \
    mkdir -p /opt/csvn && \
    tar -xzf /tmp/csvn.tgz -C /opt/csvn --strip=1 && \
    rm -rf /tmp/csvn.tgz

ENV RUN_AS_USER collabnet


RUN useradd collabnet && \
    chown -R collabnet.collabnet /opt/csvn && \
    cd /opt/csvn && \
    ./bin/csvn install && \
    mkdir -p ./data-initial && \
    cp -r ./data/* ./data-initial

EXPOSE 3343 4434 18080

ADD files /

VOLUME /opt/csvn/data

WORKDIR /opt/csvn

ENTRYPOINT ["/config/bootstrap.sh"]
