#!/usr/bin/env bash

# Install command-line tools using Homebrew.

# Make sure we’re using the latest Homebrew.
brew update;

# Upgrade any already-installed formulae.
brew upgrade;

# Install GNU core utilities (those that come with macOS are outdated).
# Don’t forget to add `$(brew --prefix coreutils)/libexec/gnubin` to `$PATH`.
brew install coreutils;

# Install some other useful utilities like `sponge`.
brew install moreutils;
# Install GNU `find`, `locate`, `updatedb`, and `xargs`, `g`-prefixed.
brew install findutils;
# Install GNU `sed`, overwriting the built-in `sed`.
brew install gnu-sed --with-default-names;

source $HOME/.symmetry/installs/bash.bash;

brew tap homebrew/versions;
brew install bash-completion2

source $HOME/.symmetry/installs/screenfetch.bash;
source $HOME/.symmetry/installs/tldr.bash;

brew install thefuck;


# Install more recent versions of some macOS tools.
brew install vim --with-override-system-vi
brew install homebrew/dupes/grep --with-default-names
brew install homebrew/dupes/openssh
brew install homebrew/dupes/screen

source $HOME/.symmetry/installs/ruby.bash;

source $PWD/.symmetry/installs/node.bash;


brew install ack;
brew install dark-mode;

brew install git;
brew install git-lfs;
brew install imagemagick --with-webp;
brew install lua;
brew install lynx;
brew install p7zip;
brew install pigz;
brew install pv;
brew install rename;
brew install rhino;
brew install speedtest_cli;
brew install ssh-copy-id;
brew install testssl;
brew install tree;
brew install vbindiff;
brew install webkit2png;
brew install zopfli;
