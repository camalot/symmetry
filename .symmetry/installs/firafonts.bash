#!/usr/bin/env bash

# install unzip just in case the user doesn't already have it.
if [[ `uname` = Linux ]]; then
    sudo apt-get install unzip -y;
    wget "http://www.carrois.com/downloads/fira_4_1/FiraFonts4106.zip";
    wget "http://www.carrois.com/downloads/fira_mono_3_2/FiraMonoFonts3206.zip";
    unzip FiraSans4106.zip;
    unzip FiraMono3206.zip;
    sudo mkdir -p /usr/share/fonts/truetype/FiraSans;
    sudo mkdir -p /usr/share/fonts/opentype/FiraSans;
    sudo cp Fira*/WEB/*.ttf /usr/share/fonts/truetype/FiraSans/;
    sudo cp Fira*/OTF/Fira* /usr/share/fonts/opentype/FiraSans/;
    sudo fc-cache -fv;
else
    # wget https://github.com/mozilla/Fira/archive/4.202.zip
    # unzip 4.202.zip
    # font_dir="$HOME/Library/Fonts"
    # mkdir -p $font_dir
    # cp Fira-4.202/otf/* $font_dir/

		brew tap caskroom/fonts;
		brew cask install font-fira-code font-fira-mono font-fira-mono-for-powerline font-fira-sans;

fi
