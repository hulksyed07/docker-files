# Set the base image
FROM ubuntu:16.04

# Dockerfile author / maintainer
MAINTAINER Syed Mehndi <hulk.syed07@gmail.com>

# Install essentials packages
RUN apt-get update -qq && \
    apt-get autoremove -y && \
    apt-get install -y alien dpkg-dev debhelper build-essential make && \
    apt-get install -y apt-transport-https ca-certificates

# Adding oracle install file to tmp folder
ADD oracle-instantclient*.rpm /tmp/

# Convert RPM files to DEB
RUN alien -k --scripts /tmp/oracle-instantclient*.rpm

# Installing oracle instant client
RUN dpkg -i oracle-instantclient*.deb && \
    rm -rf /var/cache/apt && \
    rm -f /tmp/oracle-instantclient*.rpm && \
    rm -f oracle-instantclient*.deb

# Setting paths for oracle client
ENV ORACLE_HOME /usr/lib/oracle/12.1/client64/lib
ENV LD_LIBRARY_PATH /usr/lib/oracle/12.1/client64/lib

#installing rvm
#RUN gpg --keyserver hkp://keys.gnupg.net:80 --recv-keys 409B6B1796C275462A1703113804BB82D39DC0E3 7D2BAF1CF37B13E2069D6956105BD0E739499BDB && \

#RUN apt-key adv --keyserver hkp://keys.gnupg.net:80 --recv-key D6FB2970
#RUN apt-get install -y gnup2
#RUN \curl -sSL https://rvm.io/mpapis.asc | gpg2 --import -
RUN \curl -#LO https://rvm.io/mpapis.asc

RUN gpg --import mpapis.asc

#RUN \curl -sSL https://get.rvm.io | bash -s stable --ruby

#RUN \curl -sSL https://get.rvm.io | bash -s stable --ruby --auto-dotfiles

RUN \curl -sSL https://get.rvm.io | bash -s stable

#RUN /bin/bash -l -c "rvm requirements"
#RUN /bin/bash -l -c "rvm install 2.4.0"
#RUN /bin/bash -l -c "gem install bundler --no-ri --no-rdoc"


RUN /bin/bash -l -c ". /etc/profile.d/rvm.sh && rvm install 2.4.0 && gem install bundler --no-ri --no-rdoc"

ENTRYPOINT ["/bin/bash", "-l", "-c"]
