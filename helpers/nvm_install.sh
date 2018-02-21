#!/usr/bin/env bash

NVM_DIR="/home/vagrant/.nvm"

if ! hash git 2>/dev/null; then
  echo >&2 "!!! You need to install git"
  exit 1
fi

if [ -d "$NVM_DIR" ]; then
  echo ">>> NVM is already installed in $NVM_DIR, trying to update"
  echo -ne "\r=> "
  cd $NVM_DIR && git pull
else
  # Cloning to $NVM_DIR
  git clone https://github.com/creationix/nvm.git $NVM_DIR
fi

PROFILE="/home/vagrant/.profile"
ZPROFILE="/home/vagrant/.zprofile"
SOURCE_STR="\n# This loads NVM\n[[ -s /home/vagrant/.nvm/nvm.sh ]] && . /home/vagrant/.nvm/nvm.sh"

# Append NVM script to ~/.profile
if ! grep -qsc 'nvm.sh' $PROFILE; then
  echo ">>> Appending source string to $PROFILE"
  printf "$SOURCE_STR" >> "$PROFILE"
else
  echo ">>> Source string already in $PROFILE"
fi

ZSHRC="/home/vagrant/.zshrc"
if [ ! -f  $ZSHRC ]; then
    # Append NVM script to ~/.zprofile
    if ! grep -qsc 'nvm.sh' $ZPROFILE; then
      echo ">>> Appending source string to $ZPROFILE"
      printf "$SOURCE_STR" >> "$ZPROFILE"
    else
      echo ">>> Source string already in $ZPROFILE"
    fi
fi