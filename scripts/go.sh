#!/usr/bin/env bash

# check if a go version is set
if [[ -z $1 ]]; then
        GO_VERSION="latest"
else
        GO_VERSION=$1
fi

if [[ $GO_VERSION -eq "latest" ]]; then
    curl https://raw.githubusercontent.com/tscheckenbach/golang-install/master/install.sh | sudo bash
else 
    curl -SL https://raw.githubusercontent.com/tscheckenbach/golang-install/master/install.sh | sudo bash /dev/stdin $GO_VERSION
fi
