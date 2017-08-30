#!/usr/bin/env bash

echo ">>> Installing Apache ActiveMQ"
# Install prerequisite: Java
# -qq implies -y --force-yes
sudo apt-get update
sudo apt-get -qq install default-jre

cd /tmp
wget -O activemq.tar.gz 'http://www.apache.org/dyn/closer.cgi?filename=/activemq/5.15.0/apache-activemq-5.15.0-bin.tar.gz&action=download'
tar -xzf activemq.tar.gz
sudo mv apache-activemq-5.15.0 /opt/activemq

cat > /etc/systemd/system/activemq.service << EOF
[Unit]
Description=Apache ActiveMQ
After=network-online.target

[Service]
Type=forking
WorkingDirectory=/opt/activemq/bin
ExecStart=/opt/activemq/bin/activemq start
ExecStop=/opt/activemq/bin/activemq stop
Restart=on-abort
User=activemq
Group=activemq

[Install]
WantedBy=multi-user.target
EOF
sudo systemctl enable activemq.service
sudo systemctl start activemq

echo ">>> Apache ActiveMQ installed"

# Test if PHP is installed
php -v > /dev/null 2>&1
PHP_IS_INSTALLED=$?

if [ $PHP_IS_INSTALLED -eq 0 ]; then
    PHP_VERSION=$1

    echo ">>> Install STOMP"
    # install pear and needed dependencies for pecl
    sudo apt-get -qq install pkg-config openssl php-xml php-pear php-dev

    # install stomp and say no to SSL
    echo "no" | sudo pecl install stomp > /dev/null

    echo "extension=stomp.so" | sudo tee /etc/php/$PHP_VERSION/mods-available/stomp.ini
    sudo phpenmod stomp
fi