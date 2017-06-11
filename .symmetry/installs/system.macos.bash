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
# Install Bash 4.
# Note: don’t forget to add `/usr/local/bin/bash` to `/etc/shells` before
# running `chsh`.
brew tap homebrew/versions;
# brew install bash-completion2
