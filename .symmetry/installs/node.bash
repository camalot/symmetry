#!/usr/bin/env bash

sudo curl -sL https://deb.nodesource.com/setup_6.x | sudo -E bash -
sudo apt install nodejs;

sudo npm install npm -g -u;
sudo npm install -g grunt jasmine codecov;
