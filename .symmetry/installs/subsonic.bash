#!/usr/bin/env bash

_install_subsonic() {
	local env_line="JAVA_HOME=/usr/lib/jvm/jdk-8-oracle-arm-vfp-hflt\n";
	local env_file="/etc/environment";
	local subsonic_version="6.1.1";
	local subsonic_args="--port=9988 --max-memory=200"

	sudo apt-get install oracle-java8-jdk -y;

	local jvm=$(java --version);
	if [ ! "$jvm" =~ "java version \"1.8.0\"" ]; then
		if grep -Fxq "$env_line" "$env_file"; then
			echo "skipping '${env_line}'";
		else
			echo "$env_line" >> "$env_file";
		fi
	fi
	if ! command -v subsonic > /dev/null 2>&1; then
		wget -P "$HOME/" –O "subsonic-${subsonic_version}.deb" "https://s3-eu-west-1.amazonaws.com/subsonic-public/download/subsonic-${subsonic_version}.deb";
		sudo dpkg -i "$HOME/subsonic-${subsonic_version}.deb";
		rm "$HOME/subsonic-${subsonic_version}.deb";
	fi

	sudo /etc/init.d/subsonic stop;

	if ! id -u subsonic > /dev/null 2>&1; then
		sudo adduser subsonic;
		sudo adduser subsonic audio;
	fi

	sudo sed -e 's|SUBSONIC_USER=root|SUBSONIC_USER=subsonic|' -e "s|SUBSONIC_ARGS=\".*\"$|SUBSONIC_ARGS=\"${subsonic_args}\"|g" /etc/default/subsonic > $HOME/subsonic.tmp;
	sudo mv $HOME/subsonic.tmp /etc/default/subsonic;
	sudo chown subsonic:subsonic /var/subsonic -Rv;

	 # install nginx? for reverse proxy?

	sudo /etc/init.d/subsonic start;


	__symmetry_notice "\tBe sure to login and configure subsonic!'";

}

_install_subsonic;
