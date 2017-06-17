function __symmetry_completion() {
	shopt -s dotglob;
	shopt -s extglob;

	COMPREPLY=();
	local cur="${COMP_WORDS[COMP_CWORD]}";
	local prev="${COMP_WORDS[COMP_CWORD-1]}";
	local prev2="${COMP_WORDS[COMP_CWORD-2]}";

	local words="--help --version install init set-prompt get-prompt list load";
	local list_actions=$(for d in $(ls ~/.symmetry/); do d=${d%*/}; echo ${d##*/}; done;);
	case "${prev}" in
		install)
			if [ -d "$HOME/.symmetry/installs" ]; then
				# all non-system specific files and 'this' file
		    local FILES="$HOME/.symmetry/installs/!(._*).bash";
		    local names=$(for f in $FILES; do f=${f##*/}; echo ${f%.bash}; done; );
				COMPREPLY=( $(compgen -W "${names}" -- ${cur}) );
		  fi
			return 0;
		;;
		list|load)
			if [ -d "$HOME/.symmetry" ]; then
				local names=$list_actions;
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
			case "${prev2}" in
				load|list)
					if [ -d "$HOME/.symmetry/${prev}" ]; then
						# all non-system specific files and 'this' file
						local FILES="$HOME/.symmetry/${prev}/!(._*).bash";
						local names=$(for f in $FILES; do f=${f##*/}; echo ${f%.bash}; done; );
						COMPREPLY=( $(compgen -W "${names}" -- ${cur}) );
					fi
					return 0;
				;;
				*)
				;;
			esac
		;;
	esac
	COMPREPLY=($(compgen -W "${words}" -- ${cur}));
	return 0;
}
complete -F __symmetry_completion symmetry;
