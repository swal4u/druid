FROM openjdk:8

LABEL maintainer="Stéphane Walter <stephane.walter@me.com>"
LABEL REFRESHED_AT="2019-09-07"
LABEL version="DRUID 0.15.1"

# We will be running Druid as `root` user.
USER root
WORKDIR /root/

# Druid related variables.
ARG DRUID_VERSION=0.15.1-incubating
ARG DRUID_BINARY_ARCHIVE_NAME=apache-druid-${DRUID_VERSION}
ARG DRUID_BINARY_DOWNLOAD_URL=https://www-eu.apache.org/dist/incubator/druid/${DRUID_VERSION}/${DRUID_BINARY_ARCHIVE_NAME}-bin.tar.gz

# Zookeeper related variables.
ARG ZOOKEEPER_VERSION=3.4.11
ARG ZOOKEEPER_BINARY_ARCHIVE_NAME=zookeeper-${ZOOKEEPER_VERSION}
ARG ZOOKEEPER_BINARY_DOWNLOAD_URL=https://archive.apache.org/dist/zookeeper/${ZOOKEEPER_BINARY_ARCHIVE_NAME}/${ZOOKEEPER_BINARY_ARCHIVE_NAME}.tar.gz

# Configure env variables for Druid.
# Also configure PATH env variable to include binary folders of Java and Druid.

ENV DRUID_HOME  /usr/local/druid
ENV ZOOKEEPER_HOME /usr/local/druid/zk
ENV PATH $JAVA_HOME/bin:$DRUID_HOME/bin:$PATH

# Download, uncompress and move all the required packages and libraries to their corresponding directories in /usr/local/ folder.
RUN wget -c ${DRUID_BINARY_DOWNLOAD_URL} -O - | tar -xz && \
    mv ${DRUID_BINARY_ARCHIVE_NAME} /usr/local/druid && \
    wget -c ${ZOOKEEPER_BINARY_DOWNLOAD_URL} -O - | tar -xz && \
    mv ${ZOOKEEPER_BINARY_ARCHIVE_NAME} /usr/local/druid/zk

# Modify configuration to have exact count distinct
ADD $PWD/broker/runtime.properties /usr/local/druid/conf/druid/single-server/micro-quickstart/broker/runtime.properties

EXPOSE 8888

CMD ["start-micro-quickstart"]