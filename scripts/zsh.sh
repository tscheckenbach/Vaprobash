#!/usr/bin/env bash

echo ">>> Install Oh-My-ZSH"
sudo apt-get install -y zsh
wget http://install.ohmyz.sh -O - | zsh

echo ">>> Install powerlevel9k theme"
git clone https://github.com/bhilburn/powerlevel9k.git /home/vagrant/.oh-my-zsh/custom/themes/powerlevel9k
sed -i 's/ZSH_THEME="robbyrussell"/ZSH_THEME="powerlevel9k\/powerlevel9k"/' /home/vagrant/.zshrc

echo ">>> Install Z"
git clone https://github.com/rupa/z.git
mv z/z.sh /home/vagrant/.z.sh
touch /home/vagrant/.z
rm -rf z

echo ">>> Activate Z and update powerlevel9k config"
cat >> /home/vagrant/.zshrc << EOF
# Enable Z
. ~/.z.sh
# POWERLEVEL9K SETTINGS #
POWERLEVEL9K_LEFT_PROMPT_ELEMENTS=(os_icon dir vcs)
POWERLEVEL9K_RIGHT_PROMPT_ELEMENTS=(load ram)
POWERLEVEL9K_DISABLE_RPROMPT=true
POWERLEVEL9K_SHORTEN_DIR_LENGTH=2
EOF

sudo chsh -s /bin/zsh vagrant
