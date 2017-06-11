# Symmetry

The purpose of this is to create a consistent bash experience across multiple devices that run bash; MacOS, Ubuntu, Raspbian, Windows 10 (WSL).

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

### FEATURES

- `git` repository aware prompt
```
ryan@bane ~/Development/projects/github/symmetry [develop 1↑]
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
