# Symmetry

The purpose of this is to create a consistent bash experience across multiple devices that run bash; MacOS, Ubuntu, Raspbian, Windows 10 (WSL).

`This is a WIP and is how I set up my systems but could be used for your systems.`

### INSTALL

```
$ git clone https://github.com/camalot/symmetry.git && cd symmetry && bash bootstrap.sh
```

Run the system application install (bundle is optional)
```
$ symmetry install [bundle]
```

Run the initialization scripts (this happens automatically when bootstrapped):
```
$ symmetry init
```

Set the prompt to one of the defined prompts (currently only `default`)
```
$ symmetry set-prompt [prompt]
```
