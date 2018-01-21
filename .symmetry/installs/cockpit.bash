#!/usr/bin/env bash

function _install_cockpit() {
	case $(__symmetry_platform) in
		ubuntu|debian|windows)
			sudo apt update;
			sudo apt install cockpit cockpit-docker cockpit-machines;
			sudo systemctl status cockpit;
		;;
		*)
		;;
	esac
}

_install_cockpit;
