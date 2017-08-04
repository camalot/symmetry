#!/usr/bin/env bash

sudo apt install nginx;
sudo update-rc.d nginx defaults;
sudo /etc/init.d/nginx start;
