#!/usr/bin/env bash

echo ">>> Setting up Vim"

if [[ -z $1 ]]; then
    github_url="https://raw.githubusercontent.com/fideloper/Vaprobash/master"
else
    github_url="$1"
fi

# Create directories needed for some .vimrc settings
mkdir -p /home/ubuntu/.vim/backup
mkdir -p /home/ubuntu/.vim/swap

# Install Vundle and set owner of .vim files
git clone https://github.com/gmarik/vundle.git /home/ubuntu/.vim/bundle/vundle
sudo chown -R vagrant:vagrant /home/ubuntu/.vim

# Grab .vimrc and set owner
curl --silent -L $github_url/helpers/vimrc > /home/ubuntu/.vimrc
sudo chown vagrant:vagrant /home/ubuntu/.vimrc

# Install Vundle Bundles
sudo su - vagrant -c 'vim +BundleInstall +qall'
