#!/usr/bin/env bash

# Shell prompt based on the Solarized Dark theme.
# Screenshot: http://i.imgur.com/EkEtphC.png
# Heavily inspired by @necolass prompt: https://github.com/necolas/dotfiles
# iTerm  Profiles  Text  use 13pt Monaco with 1.1 vertical spacing.

clear #for background artifacting

if [[ $COLORTERM = gnome-* && $TERM = xterm ]] && infocmp gnome-256color >/dev/null 2>&1; then
	export TERM='gnome-256color';
elif infocmp xterm-256color >/dev/null 2>&1; then
	export TERM='xterm-256color';
fi;
prompt_git() {
	local s='';
	local branchName='';

	local branchUntrackedSymbol='Ω'
	local branchIdenticalSymbol='≡'
	local branchGoneSymbol='×'
	local branchAheadSymbol='↑'
	local branchBehindSymbol='↓'
	local branchBehindAndAheadSymbol='↕'
	local branchBorkedSymbol='≠'

	local fileUntrackedSymbol='?'
	local fileAddedSymbol='+'
	local fileRemovedSymbol='-'
	local fileModifiedSymbol='~'
	local fileConflictSymbol='!'
	local fileStashedSymbol='$'

	# Check if the current directory is in a Git repository.
	if [ $(git rev-parse --is-inside-work-tree &>/dev/null; echo "${?}") == '0' ]; then

		# check if the current directory is in .git before running git checks
		if [ "$(git rev-parse --is-inside-git-dir 2> /dev/null)" == 'false' ]; then

			# Ensure the index is up to date.
			git update-index --really-refresh -q &>/dev/null;

			local UPSTREAM=$(git rev-parse --abbrev-ref --symbolic-full-name @{u} 2> /dev/null)
			local LOCAL_BRANCH_SHA=$(git rev-parse --verify @)
			local REMOTE_BRANCH_SHA=$(git rev-parse --verify "$UPSTREAM" 2> /dev/null || git rev-parse --verify @)
			local BASE_BRANCH_SHA=$(git merge-base @ "$UPSTREAM" 2> /dev/null || git rev-parse --verify @)

			local BEHIND_COUNT=$(git rev-list --left-only --count $UPSTREAM...@ 2> /dev/null || echo 0)
			local AHEAD_COUNT=$(git rev-list --right-only --count $UPSTREAM...@ 2> /dev/null || echo 0)

			local branchColor="${pfg_cyan}"

			# Check for uncommitted changes in the index.
			if ! $(git diff --quiet --ignore-submodules --cached); then
				s+="${pfg_green}${fileAddedSymbol}${pfg_blue}";
			fi;

			# Check for unstaged changes.
			if ! $(git diff-files --quiet --ignore-submodules --); then
				s+="${pfg_red}${fileConflictSymbol}${pfg_blue}";
			fi;

			# Check for untracked files.
			if [ -n "$(git ls-files --others --exclude-standard)" ]; then
				s+="${pfg_yellow}${fileUntrackedSymbol}${pfg_blue}";
			fi;

			# Check for stashed files.
			if $(git rev-parse --verify refs/stash &>/dev/null); then
				s+="${pfg_white}${fileStashedSymbol}${pfg_blue}";
			fi;

			if [ ! $UPSTREAM = '' ]; then
				if [ $LOCAL_BRANCH_SHA = $REMOTE_BRANCH_SHA ]; then
					branchColor="${pfg_cyan}"
					s+="${pfg_cyan}${branchIdenticalSymbol}"
				elif [ $BEHIND_COUNT -gt 0 ] && [ $AHEAD_COUNT -gt 0 ]; then
					branchColor="${pfg_cyan}"
					s+="${pfg_orange}${BEHIND_COUNT}${branchBehindAndAheadSymbol}${AHEAD_COUNT}"
				# elif [ $LOCAL_BRANCH_SHA = $BASE_BRANCH_SHA ]; then
				elif [ $BEHIND_COUNT -gt 0 ]; then
					branchColor="${pfg_orange}"
					s+="${pfg_orange}${BEHIND_COUNT}${branchBehindSymbol}"
				# elif [ $REMOTE_BRANCH_SHA = $BASE_BRANCH_SHA ]; then
				elif [ $AHEAD_COUNT -gt 0 ]; then
					branchColor="${pfg_cyan}"
					s+="${pfg_green}${AHEAD_COUNT}${branchAheadSymbol}"
				else
					branchColor="${pfg_red}"
					s+="${pfg_red}${branchBorkedSymbol}"
				fi
			else
				branchColor="${pfg_red}"
				s+="${pfg_red}${branchUntrackedSymbol}"
			fi

		fi

		# Get the short symbolic ref.
		# If HEAD isnt a symbolic ref, get the short SHA for the latest commit
		# Otherwise, just give up.
		branchName="$(git symbolic-ref --quiet --short HEAD 2> /dev/null || \
			git rev-parse --short HEAD 2> /dev/null || \
			echo '???')";

		[ -n "${s}" ] && s=" ${s}";

		echo -e " ${branchColor}[${branchName}${s}${branchColor}]";
	else
		return;
	fi;
}

# set the default text color. this only works in tty (eg $TERM == "linux"), not pts (eg $TERM == "xterm")
# setterm -background black -foreground green -store

if tput setaf 1 &> /dev/null; then
	tput sgr0; # reset colors
	bold=$(tput bold);
	reset=$(tput sgr0);
	# Solarized colors, taken from http://git.io/solarized-colors.
	pfg_black=$(tput setaf 0);
	pfg_blue=$(tput setaf 33);
	pfg_cyan=$(tput setaf 37);
	pfg_green=$(tput setaf 64);
	pfg_orange=$(tput setaf 166);
	pfg_purple=$(tput setaf 125);
	pfg_red=$(tput setaf 124);
	pfg_violet=$(tput setaf 61);
	pfg_white=$(tput setaf 15);
	pfg_yellow=$(tput setaf 136);
else
	bold='\e[1m';
	underline='\e[4m' # doesn't seem to work in tty
	reverse='\e[7m'
	blinking='\e[5m' # doesn't seem to work in tty
	reset="\e[0m";

	pbg_black=40
	pbg_red=41
	pbg_green=42
	pbg_yellow=43
	pbg_blue=44
	pbg_magenta=45
	pbg_cyan=46
	pbg_white=47

	pfg_black="\e[1;30m";
	pfg_blue="\e[1;34m";
	pfg_cyan="\e[1;36m";
	pfg_green="\e[1;32m";
	pfg_orange="\e[1;33m";
	pfg_purple="\e[1;35m";
	pfg_red="\e[1;31m";
	pfg_violet="\e[1;35m";
	pfg_white="\e[1;37m";
	pfg_yellow="\e[1;33m";

	cs_default=0 # hardware cursor (blinking)
	cs_invisible=1 # hardware cursor (blinking)
	cs_underscore=2 # hardware cursor (blinking)
	cs_lower_third=3 # hardware cursor (blinking)
	cs_lower_half=4 # hardware cursor (blinking)
	cs_two_thirds=5 # hardware cursor (blinking)
	cs_full_block_blinking=6 # hardware cursor (blinking)
	cs_full_block=16 # software cursor (non-blinking)

	cbg_black=0 # same color 0-15 and 128-infinity
	cbg_blue=16 # same color 16-31
	cbg_green=32 # same color 32-47
	cbg_cyan=48 # same color 48-63
	cbg_red=64 # same color 64-79
	cbg_magenta=80 # same color 80-95
	cbg_yellow=96 # same color 96-111
	cbg_white=112 # same color 112-127

	cfg_default=0 # same color as the other terminal text
	cfg_cyan=1
	cfg_black=2
	cfg_grey=3
	cfg_lightyellow=4
	cfg_white=5
	cfg_lightred=6
	cfg_magenta=7
	cfg_green=8
	cfg_darkgreen=9
	cfg_darkblue=10
	cfg_purple=11
	cfg_yellow=12
	cfg_white=13
	cfg_red=14
	cfg_pink=15

	cursor_styles="\e[?${cs_full_block};${cfg_black};${cbg_green};c" # only seems to work in tty
fi;

# Highlight the user name when logged in as root.
if [[ "${USER}" == "root" ]]; then
	userStyle="${bold}${pfg_red}";
else
	userStyle="${pfg_orange}";
fi;

# Highlight the hostname when connected via SSH.
if [[ "${SSH_TTY}" ]]; then
	hostStyle="${bold}${pfg_red}";
else
	hostStyle="${pfg_yellow}";
fi;

# Define the default prompt terminator character '$'
if [[ "$UID" == 0 ]]; then
  prompt_symbol="#"
else
  prompt_symbol="\$"
fi

# Set the terminal title and prompt.
#trap 'echo -ne "\033]0;$BASH_COMMAND\007"' DEBUG
PS1="\[\033]0;\u@\H | \W\007\]"; # working directory base name
PS1+="\[${bold}\]\n"; # newline
PS1+="\[${userStyle}\]\u"; # username
PS1+="\[${pfg_white}\]@";
PS1+="\[${hostStyle}\]\h"; # host
PS1+="\[${pfg_white}\] ";
PS1+="\[${pfg_green}\]\w"; # working directory full path
PS1+="\$(prompt_git)"; # Git repository details
PS1+="\n";
PS1+="\[${pfg_white}\]\[${prompt_symbol}\] \[${reset}\]"; # `$` (and reset color)
export PS1;

PS2="\[${pfg_yellow}\] \[${reset}\]";
export PS2;
