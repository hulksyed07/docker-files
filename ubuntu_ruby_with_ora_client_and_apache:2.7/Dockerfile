#Set the base image
FROM ruby:2.7

# Dockerfile author / maintainer
MAINTAINER Syed Mehndi <hulk.syed07@gmail.com>

USER root

# Install essentials packages
RUN apt-get update -qq && \
    apt-get autoremove -y && \
    apt-get install -y alien dpkg-dev debhelper build-essential make

# As dpkg is misbehaving: https://bugs.debian.org/cgi-bin/bugreport.cgi?bug=863199
# Issue reported on git: https://github.com/puckel/docker-airflow/issues/182
# So explicitly creating diirectory mkdir -p /usr/share/man/man1/
# openjdk-8 is not found directly so adding this extra step add-apt-repository ppa:openjdk-r/ppa
RUN mkdir -p /usr/share/man/man1/ && \
    apt-get update && \
    apt-get install -y openjdk-11-jre openjdk-11-jdk libaio1 unzip sudo nano git-core

# Adding oracle install file to tmp folder
ADD oracle-instantclient*.rpm /tmp/

# Convert RPM files to DEB
RUN alien -k --scripts /tmp/oracle-instantclient*.rpm

# Installing oracle instant client
RUN dpkg -i oracle-instantclient*.deb && \
    rm -rf /var/cache/apt && \
    rm -f /tmp/oracle-instantclient*.rpm && \
    rm -f oracle-instantclient*.deb && \
    echo /usr/lib/oracle/12.2/client64/lib > /etc/ld.so.conf.d/oracle-instantclient12.2.conf && ldconfig

ENV ORACLE_HOME=/usr/lib/oracle/12.2/client64/lib  \
    LD_LIBRARY_PATH=/usr/lib/oracle/12.2/client64/lib  \
    JAVA_HOME=/usr/lib/jvm/java-8-openjdk-amd64

RUN gem update --system

RUN gem install bundler

#RUN gem update bundler

RUN gem install 'ruby-oci8'

# install things globally, for great justice
ENV GEM_HOME=/usr/local/bundle  \
    PATH=$GEM_HOME/bin:$PATH

RUN bundle config --global path "$GEM_HOME"  && \
    bundle config --global bin "$GEM_HOME/bin"

# don't create ".bundle" in all our apps
ENV BUNDLE_APP_CONFIG $GEM_HOME

# # Post using bundler 2.1.4 gems are getting installed in 2 locations /usr/local/bundle/gems, /usr/local/bundle/ruby/2.6.0/gems
# and github master repo obtained gems are stored at /usr/local/bundle/ruby/2.6.0/bundler/gems
# ENV GEM_PATH=/usr/local/bundle/ruby/2.6.0:/usr/local/bundle/ruby/2.6.0/bundler

# RUN bundle install --path 'vendor/bundle'

# Install apache with passenger
RUN apt-get install -y dirmngr gnupg && \
    apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys 561F9B9CAC40B2F7 && \
    apt-get install -y apt-transport-https ca-certificates && \
    sh -c 'echo deb https://oss-binaries.phusionpassenger.com/apt/passenger bionic main > /etc/apt/sources.list.d/passenger.list'  && \
    apt-get update  && \
    apt-get install -y libapache2-mod-passenger && \
    apt-get install -y apache2 libapache2-mod-wsgi && \
    a2enmod passenger
