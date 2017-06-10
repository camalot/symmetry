#!/usr/bin/env bash

# nvm (Node Version Manager) completion

if [ "$NVM_DIR" ] && [ -r "$NVM_DIR"/bash_completion ];
then
  source "$NVM_DIR"/bash_completion
fi
