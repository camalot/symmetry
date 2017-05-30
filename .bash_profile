#!/usr/bin/env bash
source $HOME/.functions/._dotfiles.bash

__load_config_files functions

__load_config_files exports

__load_local_files

__load_config_files aliases
# __load_config_files completion
__load_config_files extras
