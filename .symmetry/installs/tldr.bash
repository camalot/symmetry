#!/usr/bin/env bash

wget -P $HOME/ https://raw.githubusercontent.com/raylee/tldr/master/tldr;
mv $HOME/tldr $HOME/bin/tldr;
chmod +x $HOME/bin/tldr;
