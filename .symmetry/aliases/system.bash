#!/usr/bin/env bash
# Easier navigation: .., ..., ...., ....., ~ and -
alias ..="cd ..";
alias ...="cd ../..";
alias ....="cd ../../..";
alias .....="cd ../../../..";
alias ~="cd ~"; # `cd` is probably faster to type though
alias -- -="cd -";

# Shortcuts
alias dl="cd ~/Downloads";
alias dt="cd ~/Desktop";
alias dev="cd ~/Development";
alias g="git";
alias got="git";
alias gitpush="git push";
alias nom="npm";
alias h="history";
alias j="jobs";
alias n="nano";

alias epoch='date +"%s"';
alias version='echo "bash version: ${BASH_VERSION}"';

alias mkdir="mkdir -pv";
alias wget="wget -c";

# Detect which `ls` flavor is in use
if ls --color > /dev/null 2>&1; then # GNU `ls`
	colorflag="--color";
else # macOS `ls`
	colorflag="-G";
fi

# List all files colorized in long format
alias l="ls -lF ${colorflag}";

alias ll="ls -lFA ${colorFlag}";

# List all files colorized in long format, including dot files
alias la="ls -laF ${colorflag}";

# List only directories
alias lsd="ls -lF ${colorflag} | grep --color=never '^d'";

# Always use color output for `ls`
alias ls="command ls ${colorflag}";

# Always enable colored `grep` output
# Note: `GREP_OPTIONS="--color=auto"` is deprecated, hence the alias usage.
alias grep='grep --color=auto';
alias fgrep='fgrep --color=auto';
alias egrep='egrep --color=auto';

# Enable aliases to be sudoed
alias sudo='sudo ';

# Reload the shell (i.e. invoke as a login shell)
alias reload="exec $SHELL -l";

# Print each PATH entry on a separate line
alias path='echo -e ${PATH//:/\\n}';

# Intuitive map function
# For example, to list all directories that contain a certain file:
# find . -name .gitattributes | map dirname
alias map="xargs -n1";

alias du="du -h";
alias df="df -h";

# IP addresses
alias whatsmyip="dig +short myip.opendns.com @resolver1.opendns.com";
alias ips="ifconfig -a | grep -o 'inet6\? \(addr:\)\?\s\?\(\(\([0-9]\+\.\)\{3\}[0-9]\+\)\|[a-fA-F0-9:]\+\)' | awk '{ sub(/inet6? (addr:)? ?/, \"\"); print }'";

# Show active network interfaces
alias ifactive="ifconfig | pcregrep -M -o '^[^\t:]+:([^\n]|\n\t)*status: active'";

# Canonical hex dump; some systems have this symlinked
command -v hd > /dev/null || alias hd="hexdump -C";

# macOS has no `md5sum`, so use `md5` as a fallback
command -v md5sum > /dev/null || alias md5sum="md5";

# macOS has no `sha1sum`, so use `shasum` as a fallback
command -v sha1sum > /dev/null || alias sha1sum="shasum";

command -v sha256sum > /dev/null || alias sha256sum="shasum -a 256";

# URL-encode strings
alias urlencode='python -c "import sys, urllib as ul; print ul.quote_plus(sys.argv[1]);"';

# Get week number
alias week='date +%V';

# Stopwatch
alias timer='echo "Timer started. Stop with Ctrl-D." && date && time cat && date';

# View HTTP traffic
alias sniff="sudo ngrep -d 'en1' -t '^(GET|POST) ' 'tcp and port 80'";
alias httpdump="sudo tcpdump -i en1 -n -s 0 -w - | grep -a -o -E \"Host\: .*|GET \/.*\"";

command -v gem > /dev/null && alias gems="gem list --local";
