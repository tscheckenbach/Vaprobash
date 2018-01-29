#!/usr/bin/env bash

echo ">>> Installing Mailhog"

# Download binary from github
sudo wget --quiet -O /usr/local/bin/mailhog https://github.com/mailhog/MailHog/releases/download/v0.2.0/MailHog_linux_amd64

# Make it executable
sudo chmod +x /usr/local/bin/mailhog

# Make mailhog a service
sudo tee /etc/systemd/system/mailhog.service <<EOL
[Unit]
Description=MailHog Service
After=network.service
[Service]
Type=simple
ExecStart=/usr/bin/env /usr/local/bin/mailhog > /dev/null 2>&1 &
[Install]
WantedBy=multi-user.target
EOL

sudo chmod 755 /etc/systemd/system/mailhog.service
sudo systemctl enable mailhog.service

# Start it now
sudo service mailhog start

echo ">>> Installing mhsendmail"
source /home/vagrant/.gvm/scripts/gvm
go get github.com/mailhog/mhsendmail
PHP_VERSION=$1
echo "sendmail_path = $GOPATH/bin/mhsendmail" | sudo tee /etc/php/$PHP_VERSION/mods-available/mailhog.ini
sudo phpenmod mailhog

sudo service php$PHP_VERSION-fpm restart
