#!/usr/bin/env bash

# https://github.com/ekalinin/virtualenv-bash-completion
__virtualenv_completion() {
	local cur prev opts;
	COMPREPLY=();
	cur="${COMP_WORDS[COMP_CWORD]}";
	prev="${COMP_WORDS[COMP_CWORD-1]}";
	opts=$(virtualenv --help | grep -P -o "(\s(-\w{1}|--[\w-]*=?)){1,2}" | \
				sort | uniq | grep -v "extra\-search\-dir$");

	if [[ ${cur} == -* ]] ; then
		COMPREPLY=( $(compgen -W "${opts}" -- ${cur}) );
		return 0;
	fi
}
complete -F __virtualenv_completion virtualenv;
