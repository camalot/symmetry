#!/usr/bin/env bash


source $HOME/.symmetry/functions/._symmetry.bash;
__load_config_files 'functions';

__load_config_files 'exports';
__symmetry_config_load;

__load_local_files;

__load_config_files 'aliases';
__load_config_files 'completions';
__load_config_files 'extras';

__load_config_files initializers default

load_prompt;

# __system_logo;
