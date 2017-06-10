function __symmetry_completion() {
	local cur prev opts;
	COMPREPLY=();
	cur="${COMP_WORDS[COMP_CWORD]}";
	prev="${COMP_WORDS[COMP_CWORD-1]}";
	words="--help --version install init set-prompt";

	case "${prev}" in
		install)
			if [ -d "$HOME/.symmetry/installs" ]; then
				# all non-system specific files and 'this' file
		    local FILES="$HOME/.symmetry/installs/@(!(.system.*@(windows|macos|pi|linux)|._*)).bash";
		    local names=$(for f in $FILES; do f=${f##*/}; echo ${f%.bash}; done; );
				COMPREPLY=( $(compgen -W "${names}" -- ${cur}) );
		  fi
			return 0;
		;;
		set-prompt)
			if [ -d "$HOME/.symmetry/prompts" ]; then
				# all non-system specific files and 'this' file
				local FILES="$HOME/.symmetry/prompts/*.bash";
				local names=$(for f in $FILES; do f=${f##*/}; echo ${f%.bash}; done; );
				COMPREPLY=( $(compgen -W "${names}" -- ${cur}) );
			fi
			return 0;
		;;
		*)
		;;
	esac
	COMPREPLY=($(compgen -W "${words}" -- ${cur}));
	return 0;
}
complete -F __symmetry_completion symmetry;
