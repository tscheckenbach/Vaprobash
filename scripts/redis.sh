#!/usr/bin/env bash

echo ">>> Installing Redis"

# Add repository
sudo apt-add-repository ppa:chris-lea/redis-server -y
sudo apt-get update

# Install Redis
# -qq implies -y --force-yes
sudo apt-get install -qq redis-server

# Redis Configuration
sudo mkdir -p /etc/redis/conf.d

# transaction journaling - config is written, only enabled if persistence is requested
cat << EOF | sudo tee /etc/redis/conf.d/journaling.conf
appendonly yes
appendfsync everysec
EOF

# Persistence
if [ ! -z "$2" ]; then
	if [ "$2" == "persistent" ]; then
		echo ">>> Enabling Redis Persistence"

		# add the config to the redis config includes
		if ! cat /etc/redis/redis.conf | grep -q "journaling.conf"; then
			sudo echo "include /etc/redis/conf.d/journaling.conf" >> /etc/redis/redis.conf
		fi

		# schedule background append rewriting
		if ! crontab -l | grep -q "redis-cli bgrewriteaof"; then
			line="*/5 * * * * /usr/bin/redis-cli bgrewriteaof > /dev/null 2>&1"
			(sudo crontab -l; echo "$line" ) | sudo crontab -
		fi
	fi # persistent
fi # arg check

# Test if PHP is installed
php -v > /dev/null 2>&1
PHP_IS_INSTALLED=$?

if [ $PHP_IS_INSTALLED -eq 0 ]; then
    PHP_VERSION=$1

    # install php-driver
    sudo apt-get -qq install php$PHP_VERSION-redis

    sudo service php$PHP_VERSION-fpm restart
fi

sudo service redis-server restart
