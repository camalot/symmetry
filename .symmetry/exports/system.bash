#!/usr/bin/env bash

# shellcheck disable=SC2128
__symmetry_info "$BASH_SOURCE";


# Add `~/bin` to the `$PATH`
if [[ ! ":$PATH:" == *":$HOME/bin:"* ]]; then
	export PATH="$HOME/bin:$PATH";
fi

if [ -d "$HOME/.rbenv" ]; then
	if [[ ! ":$PATH:" == *":$HOME/.rbenv/plugins/ruby-build/bin:"* ]]; then
		export PATH="$HOME/.rbenv/plugins/ruby-build/bin:$PATH";
	fi
	if [[ ! ":$PATH:" == *":$HOME/.rbenv/shims:"* ]]; then
		export PATH="$HOME/.rbenv/shims:$PATH";
	fi
	if [[ ! ":$PATH:" == *":$HOME/.rbenv/bin:"* ]]; then
		export PATH="$HOME/.rbenv/bin:$PATH";
	fi
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

if [[ ! ":$PATH:" == *":$HOME/Android/sdk/tools:"* ]] && [ -d "$HOME/Android/sdk/tools" ]; then
	export PATH="$HOME/Android/sdk/tools:$HOME/Android/sdk/tools/bin:$PATH";
fi
if [[ ! ":$PATH:" == *":$HOME/Android/sdk/platform-tools:"* ]] && [ -d "$HOME/Android/sdk/platform-tools" ]; then
	export PATH="$HOME/Android/sdk/platform-tools:$HOME/Android/sdk/emulator:$HOME/Android/sdk/build-tools/26.0.0:$PATH";
fi


if [ -d "/usr/local/go" ] && [[ ! ":$PATH:" == *":/usr/local/go:"* ]]; then
	export GOPATH=$HOME/work;
	export PATH=$PATH:/usr/local/go/bin:$GOPATH/bin;
fi

if [ -d "$HOME/.local/bin" ] && [[ ! ":$PATH:" == *":$HOME/.local/bin:"* ]]; then
	export PATH="$HOME/.local/bin:$PATH";
fi

export SYMMETRY_PROMPT=default;

export GEM_HOME=$HOME/.rbenv;

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
yellow="\e[0;33;0m";
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

splatform=$(__symmetry_platform);
if [ -f "$HOME/.symmetry/exports/.system.${splatform}.bash" ]; then
	# source the specific system functions file
	# shellcheck source=/dev/null
	source $HOME/.symmetry/exports/.system.${splatform}.bash;
fi

if [ -d "$HOME/.pyenv" ]; then
	if [[ -z "${PYENV_ROOT// }" ]]; then
		export PYENV_ROOT="$HOME/.pyenv"
	fi
	if [[ ! ":$PATH:" == *"$PYENV_ROOT/bin:"* ]]; then
		export PATH="$PYENV_ROOT/bin:$PATH"
	fi
fi


if [ -d "/usr/local/go/bin" ]; then
	if [[ ! ":$PATH:" == *"/usr/local/go/bin:"* ]]; then
	export PATH="/usr/local/go/bin:$PATH";
	fi
fi
unset splatform;
