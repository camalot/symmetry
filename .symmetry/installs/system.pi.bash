#!/usr/bin/env bash

sudo apt update;
sudo apt upgrade -y;

sudo apt install ntpdate -y;

sudo apt-get clean -y;
sudo apt-get autoremove -y;
