#!/usr/bin/env bash

# install cheat latest
# https://github.com/alexanderepstein/Bash-Snippets/blob/master/cheat/cheat
wget -P $HOME/ https://raw.githubusercontent.com/alexanderepstein/Bash-Snippets/master/cheat/cheat;
mv $HOME/cheat $HOME/bin/cheat;
chmod +x $HOME/bin/cheat;
