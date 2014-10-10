dotfiles
========

Borrows ideas from [holman's dotfiles](https://github.com/holman/dotfiles) but does a bunch of things more simply.

Put bluntly: I like reinventing the wheel.

Basic ideas:
* Subdirectories are traversed (But not subdirectories' subdirectories)
* Files and directories with the suffix .symlink are symlinked to $HOME under
* Directories with the suffix `.xdg_config` are moved under `$XDG_CONFIG_HOME`
* Existing files are *not* replaced to allow system-specific configuration where needed

Requires a POSIX `sh` compatible shell (For path substitution) and GNU findutils and coreutils (or compatible implementations of `find` and `readlink`)
