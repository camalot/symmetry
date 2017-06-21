# Symmetry

The purpose of this is to create a consistent bash experience across multiple devices that run bash; MacOS, Ubuntu, Raspbian, Windows 10 (WSL).

This was initially inspired by [Mathias Bynens' dotfiles](https://github.com/mathiasbynens/dotfiles).

`This is a WIP and is how I set up my systems but could be used for your systems.`

### INSTALL

```
$ git clone https://github.com/camalot/symmetry.git && cd symmetry && bash bootstrap.sh
```

Run the system application install (bundle is optional).
```
$ symmetry install [bundle]
```

Run the initialization scripts (this happens automatically when bootstrapped).
```
$ symmetry init
```

Set the prompt to one of the defined prompts (currently only `default`).
```
$ symmetry set-prompt [prompt]
```

Get the prompt that is currently loaded by Symmetry.
```
$ symmetry get-prompt
```

List out the available action groups, or actions in a group available for `load`.
```
$ symmetry list [action_group]
```

Load an action group, or a single action in a group
```
$ symmetry load action_group [action]
```

### ALIASES

- #### NAVIGATION
	- `..` : `cd ..`
	- `...` : `cd ../..`
	- `....` : `cd ../../..`
	- `.....` : `cd ../../../..`
	- `~` : `cd ~`
	- `-` : `cd -`
- #### SHORTCUTS
	- `dl` : `~/Downloads`
	- `dt` : `~/Desktop`
	- `dev` : `~/Development`
	- `g` : `git`
	- `got` : `git`
	- `gitpush` : `git push` _This exists because I constantly type this without the space._
	- `nom` : `npm`
	- `h` : `history`
	- `j` : `jobs`
	- `n` : `nano`
	- `epoch` : _unix time_
	- `version` : _bash version_
	- `reload` : _reload the login shell_
	- `path` : _list all paths in `$PATH`_
	- `map` : _intuitive mapping function_
	- `update` : _run system updates (varies per system)_
	- `whatsmyip` : _get public ip address_
	- `ips` : _get ip addresses_
	- `ifactive` : _show active network interfaces_
	- `urlencode` : _url encode a string_
	- `week` : _get week number_
	- `timer` : _a stop watch_
	- `sniff` : _view http traffic_
	- `httpdump` : _dump http traffic_

### COMPLETIONS
- `adb`
- `repo`
- `awscli`
- `bash`
- `brew`
- `bundler`
- `defaults`
- `docker`
- `docker-compose`
- `docker-machine`
- `dotnet`
- `gem`
- `git`
- `git-flow`
- `gradle`
- `grunt`
- `gulp`
- `hub`
- `kubectl`
- `makefile`
- `maven`
- `npm`
- `nvm`
- `packer`
- `pip`
- `pip3`
- `powershell`
- `rake`
- `sdkman`
- `ssh`
- `symmetry`
- `terraform`
- `test-kitchen`
- `vagrant`
- `vault`
- `virtualbox`
- `virtualenv`

### EXTRAS

Extras are a set of scripts that you can use to configure your system for settings that you do not want checked in to source control.

Only `extras/default.bash` is checked in to source, everything else in this directory is ignored.

Example:

`extras/git.bash`
```
git config --global user.name "John Q. Public";
git config --global user.email "john.q.public9999@gmail.com";
```

### FUNCTIONS

### PROMPTS

### INITIALIZERS

Initializers run on bootstrap, and on launch of bash shell. This can be used to do initalization of symlinks or making sure that ruby environment is configured. `system.*.bash`, `default.bash`, and `*.default.bash` will *NOT* run automatically



### INSTALLS
- CKB NEXT (macOS)
- dotnet
- bash
- nodejs
- octoprint (raspberry pi)
- powershell
- python3
- ruby
- screenfetch
- sdkman
- [subsonic](http://subsonic.org) (music streaming server)
- tldr
- webmin (only tested on raspberry pi)

### FEATURES

- `git` repository aware prompt
```
ryan@bane ~/Development/projects/github/symmetry [develop 1↑]
$
```
- `npm module` aware prompt
```
ryan@bane ~/Development/projects/github/osiris [osiris v1.0.0-alpha1] [develop ≡]
$
```
- `extras/*` (expect for `.default.bash`) are gitignored so you can create additional scripts that may contain things you don't want to check in to git.
- system scripts can be loaded based on the envrionment (windows, macos, rasbian, etc)
- Create `~/.symmetry/initializers/.authorized_keys` file and put your public keys in there that you want to have added to `~/.ssh/authorized_keys`. (this file is git ignored)

#### WINDOWS WSL (Bash on Ubuntu on Windows)

- Get Windows environment variables (prefixed with `WIN_`)
```
$ printwinenv
```
- Import current Windows environment variables
```
$ $(winenv)
```

- `powershell` interop from native bash
```
$ powershell Write-Host "Hello World"
Hello World
$ powershell ~/powershell-scripts/my-ps-file.ps1
```
- Get the full `lxss` path of a path within WSL
```
$ lxssdir ~
/mnt/c/Users/rconr/AppData/Local/lxss/home/rconr
```
- Convert from a Windows path to WSL path
```
$ windir "c:\\Windows\\System32\\"
/mnt/c/Windows/System32/
```
- Convert from a WSL (linux) path to Windows path
```
$ wsldir /mnt/c/Windows/System32/
C:\Windows\System32\
```
