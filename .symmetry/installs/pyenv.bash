#!/usr/bin/env bash
__symmetry_info "$BASH_SOURCE";

__pyenv_install() {
	git clone https://github.com/pyenv/pyenv.git "${HOME}/.pyenv"
}

case $(__symmetry_platform) in
	darwin|macos)
		__pyenv_install;

	;;
	microsoft|windows|pi|ubuntu|debian)
		__pyenv_install;
	;;
	*)
		echo "Unknown platform: $(__symmetry_platform)";
		exit 1;
	;;
esac


