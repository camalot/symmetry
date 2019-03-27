function __powershell_completion() {
	COMPREPLY=();
	local words="";
	local cur="${COMP_WORDS[COMP_CWORD]}";
	local prev="${COMP_WORDS[COMP_CWORD-1]}";
	words="-PSConsoleFile -Version -NoExit -Sta -Mta -NonInteractive -InputFormat -OutputFormat -File -Command --help --version";
	case "${prev}" in
		-[Ii]nputFormat|-[Oo]utputFormat)
			local names="Text XML";
			COMPREPLY=( $(compgen -W "${names}" -- ${cur}) );
			return 0;
		;;
		*)
		;;
	esac
	COMPREPLY=($(compgen -W "${words}" -- ${cur}));
	return 0;
}
complete -F __powershell_completion pwsh;
