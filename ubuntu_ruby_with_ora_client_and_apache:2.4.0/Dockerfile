# Install essentials packages
RUN apt-get update -qq && \
    apt-get autoremove -y && \
    apt-get install -y alien dpkg-dev debhelper build-essential make && \
    apt-get install -y openjdk-7-jre openjdk-7-jdk libaio1

# Adding oracle install file to tmp folder
ADD oracle-instantclient*.rpm /tmp/

# Convert RPM files to DEB
RUN alien -k --scripts /tmp/oracle-instantclient*.rpm

# Installing oracle instant client
RUN dpkg -i oracle-instantclient*.deb && \
    rm -rf /var/cache/apt && \
    rm -f /tmp/oracle-instantclient*.rpm && \
    rm -f oracle-instantclient*.deb && \
    echo /usr/lib/oracle/12.1/client64/lib > /etc/ld.so.conf.d/oracle-instantclient12.2.conf && ldconfig

ENV ORACLE_HOME=/usr/lib/oracle/12.1/client64/lib  \
    LD_LIBRARY_PATH=/usr/lib/oracle/12.1/client64/lib  \
    JAVA_HOME=/usr/lib/jvm/java-7-openjdk-amd64

RUN gem update bundler

# install things globally, for great justice
ENV GEM_HOME=/usr/local/bundle  \
    PATH=$GEM_HOME/bin:$PATH

RUN bundle config --global path "$GEM_HOME"  && \
    bundle config --global bin "$GEM_HOME/bin"

# don't create ".bundle" in all our apps
ENV BUNDLE_APP_CONFIG $GEM_HOME

#Install apache with passenger
RUN apt-get install -y apache2 && \
    apt-get install -y apt-transport-https ca-certificates && \
    apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys 561F9B9CAC40B2F7 && \
    echo 'deb https://oss-binaries.phusionpassenger.com/apt/passenger trusty main' > /etc/apt/sources.list.d/passenger.list && \
    apt-get update && \
    apt-get install -y libapache2-mod-passenger && \
    a2enmod passenger && \
    apt-get install nano
