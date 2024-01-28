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
    (
        # Freeze screen with maim and feh
        maim -u | feh -F - &
        FEH_PID=$!
        # Write selection to temporary file
        temp_path="$(mktemp)"
        sleep 0.3
        maim -s -f png "$temp_path"
        # If the tempfile isn't empty, copy it to screenshots
        if [ -s "$temp_path" ]
        then
            cat "$temp_path" | tee "$FILEPATH" | xclip -selection clipboard -t image/png
        fi
        # Remove tempfile
        rm "$temp_path"
        # Kill the temporary feh now that we're done
        kill "$FEH_PID"
    )
else
    maim -u | tee "$FILEPATH" | xclip -selection clipboard -t image/png
fi
