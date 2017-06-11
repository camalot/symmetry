#!/usr/bin/env bash

git clone https://github.com/milkbikis/powerline-shell $HOME/.symmetry/prompts/powerline;
cp $HOME/.symmetry/prompts/.powerline-config.py $HOME/.symmetry/prompts/powerline/config.py;
python $HOME/.symmetry/prompts/powerline/install.py;
