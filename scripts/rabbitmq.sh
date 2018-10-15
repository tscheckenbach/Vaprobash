#!/usr/bin/env bash

echo ">>> Installing RabbitMQ"
USER=$1
PASSWORD=$2
PHP_VERSION=$3

sudo apt-get -y install erlang-nox
wget http://www.rabbitmq.com/rabbitmq-signing-key-public.asc
sudo apt-key add rabbitmq-signing-key-public.asc
sudo apt-get update
sudo apt-get install rabbitmq-server php$PHP_VERSION-bcmath

sudo rabbitmqctl add_user $USER $PASSWORD
sudo rabbitmqctl set_permissions -p / $USER ".*" ".*" ".*"