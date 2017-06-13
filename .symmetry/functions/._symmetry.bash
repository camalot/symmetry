
function load_prompt() {
	if [ $# -eq 0 ]; then
		prompt_profile=$(if [[ $SYMMETRY_PROMPT = '' ]]; then echo 'default'; else echo $SYMMETRY_PROMPT; fi);
	else
		prompt_profile=$1;
	fi

	if [ -f "$HOME/.symmetry/prompts/${prompt_profile}.bash" ]; then
		__symmetry_config_write "SYMMETRY_PROMPT" "$prompt_profile";
		export SYMMETRY_PROMPT="${prompt_profile}";
		source $HOME/.symmetry/prompts/${prompt_profile}.bash;
	else
		echo "prompt '${prompt_profile}' not found";
	fi
}

function __symmetry_platform() {
	if [[ "${SYMMETRY_PLATFORM}" -ne '' ]]; then
		echo ${SYMMETRY_PLATFORM};
		return;
	fi
	local result="";
	if command -v lsb_release > /dev/null; then
		system=$(lsb_release -si && uname -r);
		case $(echo $system | awk '{print tolower($0)}') in
			*microsoft)
				result="windows"
			;;
			raspbian*)
				result="pi"
			;;
			ubuntu*)
				result="debian"
			;;
			*)
				result="unknown";
		esac
	else
		case $(uname -s | awk '{print tolower($0)}') in
			darwin)
				result="macos";
			;;
			cygwin|msys|win32)
				result="windows";
			;;
			linux)
				result="linux";
			;;
		esac
	fi

	__symmetry_config_write SYMMETRY_PLATFORM ${result};
	export SYMMETRY_PLATFORM="${result}";
	echo $result;
}

function __symmetry_config_write() {
	if [ "$#" -ne 2 ]; then
		return;
	fi
	local key=$1;
	local value=$2;
	local cfg_file="$HOME/.symmetryconfig";
	local line="$key=\"$value\"";
	if [ ! -f "$cfg_file" ]; then
		echo "$line" > "$cfg_file";
	else
		sed "s/$key=\".*?$\"/$line/g" $cfg_file > "$cfg_file" | echo "$line" >> "$cfg_file";
	fi
	return;
}

function __symmetry_config_load() {
	local cfg_file="$HOME/.symmetryconfig";
	if [ -f "$cfg_file" ]; then
		set -o allexport;
		source $cfg_file;
		set +o allexport;
	fi
}

function __load_config_files() {
	shopt -s dotglob;
	shopt -s extglob;
	local platform=$(__symmetry_platform);
  local subdirectory="$1"
  if [ -d "$HOME/.symmetry/${subdirectory}" ]; then
		# all non-system specific files and 'this' file
    FILES="$HOME/.symmetry/${subdirectory}/@(!(system.*@(windows|macos|pi|linux|debian)|._*|default|*.default)).bash";
    for config_file in $FILES; do
      if [ -f "${config_file}" ]; then
				echo "$config_file";
        source $config_file;
      fi
    done
  fi

	if [ -f "$HOME/.symmetry/${subdirectory}/system.${platform}.bash" ]; then
		source $HOME/.symmetry/${subdirectory}/system.${platform}.bash;
	fi
}

function __load_local_files() {
	shopt -s dotglob
	for file in $HOME/.{${system},path,bash_logout,extra}; do
		[ -r "$file" ] && [ -f "$file" ] && source "$file";
	done;
}


function __symmetry_notice() {
	if [ "$#" -gt 0 ]; then
		echo -e "\n\n\n=========================Symmetry=========================\n";
		echo -e "$1";
		echo -e "\n==========================================================\n\n\n";
	fi
}

function __symmetry_info() {
	local s=$1;
	local dir=$(dirname "$s");
	s=${s##*/};
	echo -e "running ${dir##*/} => ${s%.bash}";
}

function __symmetry_logo() {
	echo -e "\n\n\e[1;34m _______   ____  ______  ___ _____ _____________   __"
	echo "/  ___\\ \\ / /  \\/  ||  \\/  ||  ___|_   _| ___ \\ \\ / /";
	echo "\\ \`--. \\ V /| .  . || .  . || |__   | | | |_/ /\\ V / ";
	echo " \`--. \\ \\ / | |\\/| || |\\/| ||  __|  | | |    /  \\ /  ";
	echo "/\\__/ / | | | |  | || |  | || |___  | | | |\\ \\  | |  ";
	echo -e "\\____/  \\_/ \\_|  |_/\\_|  |_/\\____/  \\_/ \\_| \\_| \\_/  \e[0m\n\n";
}

function __system_logo() {
	if command -v screenfetch >/dev/null 2>&1; then
	  screenfetch -E;
	elif command -v archey > /dev/null 2>&1; then
		archey;
	fi
}
