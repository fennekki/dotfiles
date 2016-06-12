#!/bin/sh
WIRELESS_NAME="$(ip link|awk '{match($2, /(wl)[a-z0-9]*/);if (RSTART != 0) print substr($2, RSTART, RLENGTH)}'|head -1)"
WIRED_NAME="$(ip link|awk '{match($2, /(en|eth)[a-z0-9]*/);if (RSTART != 0) print substr($2, RSTART, RLENGTH)}'|head -1)"
MOBILE_NAME="$(ip link|awk '{match($2, /(enx)[a-z0-9]*/);if (RSTART != 0) print substr($2, RSTART, RLENGTH)}'|head -1)"
BATTERY_0="$(ls /sys/class/power_supply/|grep BAT0|head -1|sed 's/BAT//')"
BATTERY_1="$(ls /sys/class/power_supply/|grep BAT1|head -1|sed 's/BAT//')"
BATTERY_2="$(ls /sys/class/power_supply/|grep BAT2|head -1|sed 's/BAT//')"

WIRELESS_NAME=${WIRELESS_NAME:-"DISABLED"}
WIRED_NAME=${WIRED_NAME:-"DISABLED"}
MOBILE_NAME=${MOBILE_NAME:-"DISABLED"}
BATTERY_0=${BATTERY_0:-"DISABLED"}
BATTERY_1=${BATTERY_1:-"DISABLED"}
BATTERY_2=${BATTERY_2:-"DISABLED"}

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
if [ "$MOBILE_NAME" != "DISABLED" ]
then
    echo 'order += "ethernet '$MOBILE_NAME'"'
fi

if [ "$BATTERY_0" != "DISABLED" ]
then
    echo 'order += "battery '$BATTERY_0'"'
fi
if [ "$BATTERY_1" != "DISABLED" ]
then
    echo 'order += "battery '$BATTERY_1'"'
fi
if [ "$BATTERY_2" != "DISABLED" ]
then
    echo 'order += "battery '$BATTERY_2'"'
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

ethernet '$MOBILE_NAME' {
        format_up = "%ip"
        format_down = "⬇"
}

battery '$BATTERY_0' {
        integer_battery_capacity = true
        hide_seconds = true
        format = "%percentage %remaining"
        format_down = "-"
}

battery '$BATTERY_1' {
        integer_battery_capacity = true
        hide_seconds = true
        format = "%percentage %remaining"
        format_down = "-"
}

battery '$BATTERY_2' {
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
