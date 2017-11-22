#!/usr/bin/env bash

# The `sed` is to fix the old url that is still in the source script
curl https://raw.githubusercontent.com/raylee/tldr/master/tldr | \
	sed 's@tldr-pages\.github\.io@tldr.sh@' > $HOME/bin/tldr;
chmod +x $HOME/bin/tldr;
