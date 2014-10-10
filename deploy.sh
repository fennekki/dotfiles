#!/bin/sh

XDG_CONFIG_HOME=${XDG_CONFIG_HOME:-$HOME/.config}
echo "Config dir: $XDG_CONFIG_HOME"

# Run config
find -maxdepth 2 -name 'install.sh' -printf "Running %p:\n" -execdir /bin/sh '{}' '+'

# XDG-confoming config directories
find -maxdepth 2 -type d -name '*.xdg_config' -print |
    while read configdir
    do (
        long_name=$(readlink -f "$configdir")
        short_name="${configdir##*/}"
        link_location="$XDG_CONFIG_HOME/${short_name%.xdg_config}"
        echo "$long_name -> $link_location"
        ln -s "$long_name" "$link_location"
    ) done

# $HOME dotfiles
# Also works with directories
find -maxdepth 2 -name '*.symlink' -print |
    while read dotfile
    do (
        long_name=$(readlink -f "$dotfile")
        short_name="${dotfile##*/}"
        link_location="$HOME/${short_name%.symlink}"
        echo "$long_name -> $link_location"
        ln -s "$long_name" "$link_location"
    ) done
