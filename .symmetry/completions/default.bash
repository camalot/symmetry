#!/usr/bin/env bash

source $HOME/.symmetry/functions/._symmetry.bash || exit 2;
echo "loading completions"
__load_config_files completions;
