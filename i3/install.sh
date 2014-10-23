#!/bin/sh

XDG_CONFIG_HOME=${XDG_CONFIG_HOME:-$HOME/.config}
i3statusdir="$XDG_CONFIG_HOME/i3status"

mkdir -p "$i3statusdir"
sh generate_i3status_config.sh > "$i3statusdir/config"
echo "Generated i3status conf!"
