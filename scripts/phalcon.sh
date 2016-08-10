#!/usr/bin/env bash

PHP_VERSION=$(find /etc/php -mindepth 1 -maxdepth 1 -type d | grep -o "[[:digit:]]\.[[:digit:]]")

sudo apt-add-repository ppa:phalcon/stable
sudo apt-get update
sudo apt-get install php$PHP_VERSION-phalcon
