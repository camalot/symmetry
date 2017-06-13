#!/usr/bin/env bash

source $HOME/.symmetry/functions/._symmetry.bash || exit 2;

__load_config_files extras;

# example of using extras files:
#	git.bash >
# 	git config --global user.name "Ryan Conrad";
# 	git config --global user.email "fake.email@domain.com";
# 	# this will force ssh to auth to VSTS
# 	git config --global url."ssh://camalot@camalot.visualstudio.com/".insteadOf "https://camalot.visualstudio.com/";
