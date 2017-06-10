
function load_prompt() {
	if [ $# -eq 0 ]; then
		prompt_profile=$(if [[ $SYMMETRY_PROMPT = '' ]]; then echo 'default'; else echo $SYMMETRY_PROMPT; fi);
	else
		prompt_profile=$1;
	fi

	if [ -f "$HOME/.symmetry/prompts/${prompt_profile}.bash" ]; then
		export $SYMMETRY_PROMPT="$prompt_profile";
		source $HOME/.symmetry/prompts/${prompt_profile}.bash;
	else
		echo "prompt '${prompt_profile}' not found";
	fi
}

function dotfiles_platform() {
	if command -v lsb_release > /dev/null; then
		system=$(lsb_release -si && uname -r);
		case $(echo $system | awk '{print tolower($0)}') in
			*microsoft)
				echo "windows"
				shift;
			;;
			raspbian*)
				echo "pi"
				shift;
			;;
			ubuntu*)
				echo "debian"
				shift;
			;;
			*)
				echo "unknown";
				shift;
		esac
	else
		case $(uname -s | awk '{print tolower($0)}') in
			darwin)
				echo "macos";
				shift;
			;;
			cygwin|msys|win32)
				echo "windows";
				shift;
			;;
			linux)
				echo "linux";
				shift;
			;;
		esac
	fi
}

function __load_config_files() {
	shopt -s dotglob;
	shopt -s extglob;

  subdirectory="$1"
  if [ -d "$HOME/.symmetry/.${subdirectory}" ]; then
		# all non-system specific files and 'this' file
    FILES="$HOME/.symmetry/${subdirectory}/@(!(.system.*@(windows|macos|pi|linux)|._*)).bash";
    for config_file in $FILES; do
      if [ -f "${config_file}" ]; then
        source $config_file;
      fi
    done
  fi
}

function __load_local_files() {
	shopt -s dotglob
	system=$(dotfiles_platform)
	for file in $HOME/.{${system},path,bash_logout,extra}; do
		[ -r "$file" ] && [ -f "$file" ] && source "$file";
	done;
}

function __system_logo() {
	if command -v screenfetch >/dev/null 2>&1; then
	  screenfetch -E;
	elif command -v archey > /dev/null 2>&1; then
		archey;
	fi
}
