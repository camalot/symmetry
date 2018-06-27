#!/usr/bin/env bash

_osc_install() {
	case $(__symmetry_platform) in
		*)
			if ! command pip > /dev/null; then
				(&2> echo "pip is required to install openstack client.");
				exit 1;
			fi

			pip install python-openstackclient;
		;;
	esac


}

_osc_install "$@";

unset _osc_install;
