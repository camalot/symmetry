#!/usr/bin/env bash
source $HOME/.symmetry/functions/._symmetry.bash;

__load_config_files 'functions';

__load_config_files 'exports';

__load_local_files;

__load_config_files 'aliases';
__load_config_files 'completion';
__load_config_files 'extras';

eval "$(rbenv init -)";

load_prompt 'default';

__system_logo;
