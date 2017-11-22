#!/usr/bin/env bash
_tldr_complete() {
	local cur prev opts;
	_get_comp_words_by_ref -n : cur;

	COMPREPLY=()
	#cur="${COMP_WORDS[COMP_CWORD]}";
	prev="${COMP_WORDS[COMP_CWORD-1]}";
	opts=$(curl -s tldr.sh/assets/index.json | jq -r ".commands[] | select( .name | startswith(\"${cur}\")).name");

	COMPREPLY=( $(compgen -W "${opts}" -- ${cur}) );
	__ltrim_colon_completions "$cur";
	return 0;
}
complete -F _tldr_complete tldr;
