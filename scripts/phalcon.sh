#!/usr/bin/env bash

PHP_VERSION=$1

sudo curl -s https://packagecloud.io/install/repositories/phalcon/stable/script.deb.sh | sudo bash
sudo apt-get install php$PHP_VERSION-phalcon

sudo service php$PHP_VERSION-fpm restart
