#!/usr/bin/env bash
APT_VB_VERSION="5.1";
VB_VERSION="5.1.26";
VB_REVISION="117224";

case $(__symmetry_platform) in
	macos|darwin)

	;;
	windows|pi|ubuntu|debian)
		if [ ! -f '/etc/apt/sources.list.d/virutalbox.list' ]; then
			echo "deb http://download.virtualbox.org/virtualbox/debian xenial contrib" | sudo tee /etc/apt/sources.list.d/virutalbox.list > /dev/null;
		fi

		wget -q https://www.virtualbox.org/download/oracle_vbox_2016.asc -O- | sudo apt-key add -;
		sudo apt update;

		sudo apt install linux-headers-$(uname -r) build-essential virtualbox-$APT_VB_VERSION dkms -y;


		cd /tmp;
		wget http://download.virtualbox.org/virtualbox/${VB_VERSION}/Oracle_VM_VirtualBox_Extension_Pack-${VB_VERSION}-${VB_REVISION}.vbox-extpack;
		sudo VBoxManage extpack install Oracle_VM_VirtualBox_Extension_Pack-${VB_VERSION}-${VB_REVISION}.vbox-extpack | echo -e "y\n";

		sudo adduser $USER vboxusers;
	;;
	*)
		echo "Unknown platform: $(__symmetry_platform)";
		exit 1;
	;;
esac

unset APT_VB_VERSION;
unset VB_VERSION;
unset VB_REVISION;
