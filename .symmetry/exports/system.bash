#!/usr/bin/env bash
# Add `~/bin` to the `$PATH`
if [[ ! ":$PATH:" == *":$HOME/bin:"* ]]; then
	export PATH="$HOME/bin:$PATH";
fi
if [[ ! ":$PATH:" == *":$HOME/.rbenv/plugins/ruby-build/bin:"* ]]; then
	export PATH="$HOME/.rbenv/plugins/ruby-build/bin:$PATH";
fi
if [[ ! ":$PATH:" == *":$HOME/.rbenv/shims:"* ]]; then
	export PATH="$HOME/.rbenv/shims:$PATH";
fi
if [[ ! ":$PATH:" == *":$HOME/.rbenv/bin:"* ]]; then
	export PATH="$HOME/.rbenv/bin:$PATH";
fi
if [[ ! ":$PATH:" == *"/usr/local/aws/bin:"* ]]; then
	export PATH="/usr/local/aws/bin:$PATH";
fi
# /usr/local/bin
if [[ ! ":$PATH:" == *":/usr/local/sbin:"* ]]; then
	export PATH="/usr/local/sbin:$PATH";
fi
#/usr/local/sbin
if [[ ! ":$PATH:" == *":/usr/local/sbin:"* ]]; then
	export PATH="/usr/local/sbin:$PATH";
fi

export SYMMETRY_PROMPT=default;

export GEM_HOME=$HOME/.rbenv/bin;

# Make nano the default editor.
export EDITOR='nano';

# Enable persistent REPL history for `node`.
export NODE_REPL_HISTORY=~/.node_history;
# Allow 32 entries; the default is 1000.
export NODE_REPL_HISTORY_SIZE='32768';
# Use sloppy mode by default, matching web browsers.
export NODE_REPL_MODE='sloppy';

# Make Python use UTF-8 encoding for output to stdin, stdout, and stderr.
export PYTHONIOENCODING='UTF-8';

shopt -s histappend                                      # append to bash_history if Terminal.app quits
export HISTCONTROL=${HISTCONTROL:-ignorespace:erasedups} # erase duplicates; alternative option: export HISTCONTROL=ignoredups
export HISTSIZE=${HISTSIZE:-5000}                        # resize history size
export AUTOFEATURE=${AUTOFEATURE:-true autotest}         # Cucumber / Autotest integration

# Prefer US English and use UTF-8.
export LANG='en_US.UTF-8';
export LC_ALL='en_US.UTF-8';

# Highlight section titles in manual pages.
export LESS_TERMCAP_md="${yellow}";

# Dont clear the screen after quitting a manual page.
export MANPAGER='less -X';

shopt -s dotglob
# Case-insensitive globbing (used in pathname expansion)
shopt -s nocaseglob;
# Autocorrect typos in path names when using `cd`
shopt -s cdspell;
# add extended glob syntax
shopt -s extglob;

# Enable some Bash 4 features when possible:
# * `autocd`, e.g. `**/qux` will enter `./foo/bar/baz/qux`
# * Recursive globbing, e.g. `echo **/*.txt`
for option in autocd globstar; do
	shopt -s "$option" 2> /dev/null;
done;

SYMMETRY_PLATFORM=$(__symmetry_platform);
if [ -f "$HOME/.symmetry/exports/.system.${SYMMETRY_PLATFORM}.bash" ]; then
	# source the specific system functions file
	source $HOME/.symmetry/exports/.system.${SYMMETRY_PLATFORM}.bash;
fi

unset SYMMETRY_PLATFORM;
