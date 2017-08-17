#!/usr/bin/env bash

function _install_groovy() {
	case $(__symmetry_platform) in
		ubuntu|debian|windows)
			local GROOVY_VERSION="2.4.12";
			wget https://bintray.com/artifact/download/groovy/maven/apache-groovy-binary-${GROOVY_VERSION}.zip;
			unzip apache-groovy-binary-${GROOVY_VERSION}.zip;
			mkdir /usr/local/groovy
			mv groovy-${GROOVY_VERSION} /usr/local/groovy
			ln -s /usr/local/groovy/groovy-${GROOVY_VERSION} /usr/local/groovy/latest;

			export GROOVY_HOME=/usr/local/groovy/latest;
			export PATH=$PATH:$GROOVY_HOME/bin;

			grep -q -F 'export GROOVY_HOME=/usr/local/groovy/latest' /etc/profile.d/groovy.sh || echo 'export GROOVY_HOME=/usr/local/groovy/latest' >> /etc/profile.d/groovy.sh;
			grep -q -F 'export PATH=$PATH:$GROOVY_HOME/bin' /etc/profile.d/groovy.sh || echo 'export PATH=$PATH:$GROOVY_HOME/bin' >> /etc/profile.d/groovy.sh;
		;;
		darwin|macos)
			brew install groovy;
		;;
	esac


}


_install_groovy $@;
