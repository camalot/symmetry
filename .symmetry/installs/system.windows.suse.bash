#!/usr/bin/env bash
sudo echo "Initializing Install for Windows OpenSUSE";
sudo apt install build-essential checkinstall -y;

sudo zypper install pcregrep -y;
sudo zypper install zip unzip -y;
sudo zypper install socat -y;

source $PWD/.symmetry/installs/bash.bash;

sudo zypper install jq -y;

sudo zypper install thefuck -y;
if ! command -v 'thefuck' 2> /dev/null; then
	pip3 install thefuck -U
fi

S_GROUP=$(id -g -n $USER);
mkdir -p $HOME/bin;

source $HOME/.symmetry/installs/screenfetch.bash;
source $HOME/.symmetry/installs/tldr.bash;

sudo chown $USER:$S_GROUP -r $HOME/bin;
sudo chown $USER:$S_GROUP $HOME/.local;
sudo chown $USER:$S_GROUP $HOME/.config;

unset S_GROUP;

sudo chmod 0755 $HOME/bin -R;
sudo chmod 0755 $HOME/.local -R;
sudo chmod 0755 $HOME/.config -R;
