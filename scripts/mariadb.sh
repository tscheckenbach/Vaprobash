#!/usr/bin/env bash

echo ">>> Installing MariaDB"

[[ -z $2 ]] && { echo "!!! MariaDB root password not set. Check the Vagrant file."; exit 1; }
MARIADB_VERSION=$1

sudo apt-key adv --recv-keys --keyserver hkp://keyserver.ubuntu.com:80 0xF1656F24C74CD1D8
sudo add-apt-repository "deb [arch=amd64] http://mirror.zol.co.zw/mariadb/repo/$MARIADB_VERSION/ubuntu xenial main"
sudo apt update

# Install MariaDB without password prompt
# Set username to 'root' and password to 'mariadb_root_password' (see Vagrantfile)
sudo debconf-set-selections <<< "maria-db-$MARIADB_VERSION mysql-server/root_password password $2"
sudo debconf-set-selections <<< "maria-db-$MARIADB_VERSION mysql-server/root_password_again password $2"

# Install MariaDB
# -qq implies -y --force-yes
sudo apt-get install -qq mariadb-server

# Make Maria connectable from outside world without SSH tunnel
if [ $3 == "true" ]; then
    # enable remote access
    # setting the mysql bind-address to allow connections from everywhere
    sed -i "s/bind-address.*/bind-address = 0.0.0.0/" /etc/mysql/my.cnf

    # adding grant privileges to mysql root user from everywhere
    # thx to http://stackoverflow.com/questions/7528967/how-to-grant-mysql-privileges-in-a-bash-script for this
    MYSQL=`which mysql`

    Q1="GRANT ALL ON *.* TO 'root'@'%' IDENTIFIED BY '$2' WITH GRANT OPTION;"
    Q2="FLUSH PRIVILEGES;"
    SQL="${Q1}${Q2}"

    $MYSQL -uroot -p$2 -e "$SQL"

    service mysql restart
fi
