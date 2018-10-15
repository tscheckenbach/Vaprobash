#!/usr/bin/env bash

echo ">>> Installing RabbitMQ"

sudo apt-get -y install erlang-nox
wget http://www.rabbitmq.com/rabbitmq-signing-key-public.asc
sudo apt-key add rabbitmq-signing-key-public.asc
sudo apt-get update
sudo apt-get install rabbitmq-server

sudo rabbitmqctl add_user $1 $2
sudo rabbitmqctl set_permissions -p / $1 ".*" ".*" ".*"