#!/bin/sh
WIRELESS_NAME="$(ip link|awk '{match($2, /(wl)[a-z0-9]*/);if (RSTART != 0) print substr($2, RSTART, RLENGTH)}'|head -1)"
WIRED_NAME="$(ip link|awk '{match($2, /(en|eth)[a-z0-9]*/);if (RSTART != 0) print substr($2, RSTART, RLENGTH)}'|head -1)"
BATTERY_NUM="$(ls /sys/class/power_supply/|grep BAT|head -1|sed 's/BAT\([0-9]*\)/\1/')"

WIRELESS_NAME=${WIRELESS_NAME:-"DISABLED"}
WIRED_NAME=${WIRED_NAME:-"DISABLED"}
BATTERY_NUM=${BATTERY_NUM:-"DISABLED"}

echo '
general {
        colors = true
        interval = 1
}

order += "ipv6"'

if [ "$WIRELESS_NAME" != "DISABLED" ]
then
    echo 'order += "wireless '$WIRELESS_NAME'"'
fi
if [ "$WIRED_NAME" != "DISABLED" ]
then
    echo 'order += "ethernet '$WIRED_NAME'"'
fi

if [ "$BATTERY_NUM" != "DISABLED" ]
then
    echo 'order += "battery '$BATTERY_NUM'"'
fi

echo 'order += "load"
order += "volume master"
order += "tztime local"

ipv6 {
    format_up = "%ip"
    format_down = "4"
}

wireless '$WIRELESS_NAME' {
        format_up = "%ip:%essid:%quality"
        format_down = "⇩"
}

ethernet '$WIRED_NAME' {
        format_up = "%ip"
        format_down = "⬇"
}

battery '$BATTERY_NUM' {
        integer_battery_capacity = true
        hide_seconds = true
        format = "%percentage %remaining"
        format_down = "-"
}

tztime local {
        format = "%Y-%m-%d %H:%M:%S"
}

load {
        format = "%5min"
}

volume master {
    format = "♪ %volume"
    format_muted = "♪M%volume"
    device = "default"
    mixer = "Master"
    mixer_idx = 0
}'
