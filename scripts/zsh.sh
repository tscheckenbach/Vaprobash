#!/usr/bin/env bash

echo ">>> Install Oh-My-ZSH"
sudo apt-get install -y zsh
sudo su - ubuntu -c 'wget http://install.ohmyz.sh -O - | zsh'

echo ">>> Install powerlevel9k theme"
git clone https://github.com/bhilburn/powerlevel9k.git /home/ubuntu/.oh-my-zsh/custom/themes/powerlevel9k
sed -i 's/ZSH_THEME="robbyrussell"/ZSH_THEME="powerlevel9k\/powerlevel9k"/' /home/ubuntu/.zshrc

echo ">>> Install Z"
git clone https://github.com/rupa/z.git
mv z/z.sh /home/ubuntu/.z.sh
touch /home/ubuntu/.z
rm -rf z

echo ">>> Activate Z and update powerlevel9k config"
cat >> /home/ubuntu/.zshrc << EOF
# Enable Z
. /home/ubuntu/.z.sh
# POWERLEVEL9K SETTINGS #
POWERLEVEL9K_LEFT_PROMPT_ELEMENTS=(os_icon dir vcs)
POWERLEVEL9K_RIGHT_PROMPT_ELEMENTS=(load ram)
POWERLEVEL9K_DISABLE_RPROMPT=true
POWERLEVEL9K_SHORTEN_DIR_LENGTH=2
EOF

sudo chown -R ubuntu:ubuntu /home/ubuntu/.oh-my-zsh
sudo chown ubuntu:ubuntu /home/ubuntu/.z.sh
sudo chown ubuntu:ubuntu /home/ubuntu/.z
sudo chown ubuntu:ubuntu /home/ubuntu/.zshrc

sudo chsh -s /bin/zsh ubuntu
