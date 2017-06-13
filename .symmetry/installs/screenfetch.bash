#!/usr/bin/env bash

# install screenfetch latest
wget -P $HOME/ https://raw.githubusercontent.com/KittyKatt/screenFetch/master/screenfetch-dev;
mv $HOME/screenfetch-dev $HOME/bin/screenfetch;
chmod +x $HOME/bin/screenfetch;
