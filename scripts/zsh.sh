#!/usr/bin/env bash

echo ">>> Install Oh-My-ZSH"
sudo apt-get install -y zsh
#sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
## use installer with disabled git check
sh -c "$(curl -fsSL https://gist.githubusercontent.com/tscheckenbach/dcf3c4511b30eb14820a08d71f553002/raw/4c483fd6495ccd01ee6e7cb978d90dc3717a61af/ohMyZshInstall.sh)"

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
. /home/vagrant/.z.sh
# POWERLEVEL9K SETTINGS #
POWERLEVEL9K_LEFT_PROMPT_ELEMENTS=(os_icon dir vcs)
POWERLEVEL9K_RIGHT_PROMPT_ELEMENTS=(load ram)
POWERLEVEL9K_DISABLE_RPROMPT=true
POWERLEVEL9K_SHORTEN_DIR_LENGTH=2
EOF

sudo chown -R vagrant:vagrant /home/vagrant/.oh-my-zsh
sudo chown vagrant:vagrant /home/vagrant/.z.sh
sudo chown vagrant:vagrant /home/vagrant/.z
sudo chown vagrant:vagrant /home/vagrant/.zshrc

sudo chsh -s /bin/zsh vagrant
