#!/bin/sh

DATE="$(date +'%s')"
FILE_BASENAME="$HOME/Pictures/screenshot/${DATE}"
FILEPATH="$FILE_BASENAME.png"

# Check if it exists
# TODO: still need to check for MULTIPLE same
if [ -f "$FILEPATH" ]
then
    FILEPATH="$FILE_BASENAME.a.png"
fi

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
