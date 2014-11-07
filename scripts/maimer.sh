#!/bin/sh

DATE="$(date +'%s')"
FILEPATH="$HOME/Pictures/screenshot/${DATE}.png"

if [ "$1" = "select" -o "$2" = "select" ]
then
    maim -s --gracetime="1.0" "$FILEPATH"
else
    maim "$FILEPATH"
fi

if [ "$1" = "imgur" -o "$2" = "imgur" ]
then
    "$HOME/.dotfiles/scripts/imgurbash.sh" "$FILEPATH"
fi
