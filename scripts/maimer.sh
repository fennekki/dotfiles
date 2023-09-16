#!/bin/sh

DATE="$(date +'%s')"
FILE_BASENAME="$HOME/Pictures/screenshot/${DATE}"
FILEPATH="$FILE_BASENAME.png"

# Check if it exists
# TODO: still need to check for MULTIPLE same
if [ -f "$FILEPATH" ]
then
    FILE_COUNTER=0

    while [ -f "$FILEPATH" ]
    do
        echo $FILEPATH
        FILE_COUNTER="$((FILE_COUNTER + 1))"
        FILEPATH="$FILE_BASENAME.$FILE_COUNTER.png"
    done
    echo $FILEPATH
fi

if [ "$1" = "select" -o "$2" = "select" ]
then
    maim -d 0.0 -s | tee "$FILEPATH" | xclip -selection clipboard -t image/png
else
    maim | tee "$FILEPATH" | xclip -selection clipboard -t image/png
fi
