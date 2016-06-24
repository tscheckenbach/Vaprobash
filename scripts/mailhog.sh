#!/usr/bin/env bash

echo ">>> Installing Mailhog"

# Download binary from github
sudo wget --quiet -O /usr/local/bin/mailhog https://github.com/mailhog/MailHog/releases/download/v0.2.0/MailHog_linux_amd64

# Make it executable
sudo chmod +x /usr/local/bin/mailhog

# Make it start on reboot
sudo tee /etc/init/mailhog.conf <<EOL
description "Mailhog"
start on runlevel [2345]
stop on runlevel [!2345]
respawn
pre-start script
	exec su - vagrant -c "/usr/bin/env /usr/local/bin/mailhog > /dev/null 2>&1 &"
end script
EOL

# Start it now
sudo service mailhog start

echo ">>> Installing mhsendmail"
go get github.com/mailhog/mhsendmail
echo "sendmail_path = $GOPATH/bin/mhsendmail" | sudo tee /etc/php5/mods-available/mailhog.ini
sudo php5enmod mailhog

sudo service php5-fpm restart
