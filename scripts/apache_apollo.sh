#!/usr/bin/env bash

echo ">>> Installing Apache Apollo"
# Install prerequisite: Java
# -qq implies -y --force-yes
sudo apt-get update
sudo apt-get -qq install default-jre

cd /tmp
wget http://ftp.fau.de/apache/activemq/activemq-apollo/1.7.1/apache-apollo-1.7.1-unix-distro.tar.gz
tar -xzf apache-apollo-1.7.1-unix-distro.tar.gz
sudo mv apache-apollo-1.7.1 /opt/apache-apollo
cd /var/lib
sudo /opt/apache-apollo/bin/apollo create oi4gBroker

sudo ln -s "/var/lib/oi4gBroker/bin/apollo-broker-service" /etc/init.d/
sudo /etc/init.d/apollo-broker-service start

echo ">>> Apache Apollo installed"

# Test if PHP is installed
php -v > /dev/null 2>&1
PHP_IS_INSTALLED=$?

if [ $PHP_IS_INSTALLED -eq 0 ]; then
    PHP_VERSION=$1

    # install pear and needed dependencies for pecl
    sudo apt-get -qq install pkg-config openssl php-xml php-pear php-dev
    
    # install stomp and say no to SSL
    echo "no" | sudo pecl install stomp > /dev/null

    echo "extension=stomp.so" | sudo tee /etc/php/$PHP_VERSION/mods-available/stomp.ini
    sudo phpenmod stomp
fi