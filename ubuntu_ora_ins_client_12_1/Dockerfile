# Set the base image
FROM ubuntu:16.04

# Dockerfile author / maintainer
MAINTAINER Syed Mehndi <hulksyed07@gmail.com>

# Install essentials packages
RUN apt-get update -qq && \
    apt-get autoremove -y && \
    apt-get install -y alien dpkg-dev debhelper build-essential make

# Adding oracle install file to tmp folder
ADD oracle-instantclient*.rpm /tmp/

# Convert RPM files to DEB
RUN alien -k --scripts /tmp/oracle-instantclient*.rpm

# Installing oracle instant client
RUN dpkg -i oracle-instantclient*.deb && \
    rm -rf /var/cache/apt && \
    rm -f /tmp/oracle-instantclient*.rpm && \
    rm -f oracle-instantclient*.deb

ENV ORACLE_HOME /usr/lib/oracle/12.1/client64/lib
ENV LD_LIBRARY_PATH /usr/lib/oracle/12.1/client64/lib
