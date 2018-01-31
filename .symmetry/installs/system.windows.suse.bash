#!/usr/bin/env bash
sudo echo "Initializing Install for Windows OpenSUSE";

sudo zypper install zip unzip socat jq;

source $PWD/.symmetry/installs/bash.bash;

# sudo zypper install thefuck;

S_GROUP=$(id -g -n $USER);
mkdir -p $HOME/bin;

sudo chown -R $USER:$S_GROUP $HOME/bin;
sudo chown $USER:$S_GROUP $HOME/.local;
sudo chown $USER:$S_GROUP $HOME/.config;

unset S_GROUP;

sudo chmod 0755 $HOME/bin -R;
sudo chmod 0755 $HOME/.local -R;
sudo chmod 0755 $HOME/.config -R;
