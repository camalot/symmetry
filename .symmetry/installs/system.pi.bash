#!/usr/bin/env bash

sudo apt update;
sudo apt upgrade -y;

sudo apt install software-properties-common python-software-properties -y;

sudo apt install ntpdate -y;
sudo apt install pcregrep -y;
sudo apt install zip unzip -y;
sudo apt install socat -y;
sudo apt install jq -y;

source $PWD/.symmetry/installs/webmin.bash;


source $PWD/.symmetry/installs/bash.bash;

sudo apt install thefuck -y;
if ! command -v 'thefuck' 2> /dev/null; then
	pip3 install thefuck -U
fi

S_GROUP=$(id -g -n $USER);
mkdir -p $HOME/bin;

sudo pip install --upgrade awscli;
sudo pip install pylint behave --upgrade;

sudo chown $USER:$S_GROUP -r $HOME/bin;

sudo chmod -R 0755 $HOME/bin;


sudo apt-get clean -y;
sudo apt-get autoremove -y;
