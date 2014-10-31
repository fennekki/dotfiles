#!/bin/sh
WIRELESS_NAME="$(ip link|awk '{match($2, /(wl)[a-z0-9]*/);if (RSTART != 0) print substr($2, RSTART, RLENGTH)}'|head -1)"
WIRED_NAME="$(ip link|awk '{match($2, /(en)[a-z0-9]*/);if (RSTART != 0) print substr($2, RSTART, RLENGTH)}'|head -1)"
BATTERY_NUM="$(ls /sys/class/power_supply/|grep BAT|head -1|sed 's/BAT\([0-9]*\)/\1/')"

WIRELESS_NAME=${WIRELESS_NAME:-"DISABLED"}
WIRED_NAME=${WIRED_NAME:-"DISABLED"}
BATTERY_NUM=${BATTERY_NUM:-"DISABLED"}

echo '
general {
        colors = true
        interval = 5
}

order += "ipv6"
#order += "run_watch DHCP"
#order += "run_watch VPN"'

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

echo '#order += "disk /"
order += "load"
order += "volume master"
order += "tztime local"

wireless '$WIRELESS_NAME' {
        format_up = "W: (%quality at %essid) %ip"
        format_down = "W: down"
}

ethernet '$WIRED_NAME' {
        # if you use %speed, i3status requires root privileges
        format_up = "E: %ip (%speed)"
        format_down = "E: down"
}

battery '$BATTERY_NUM' {
        format = "%status %percentage %remaining"
}

run_watch DHCP {
        pidfile = "/var/run/dhclient*.pid"
}

run_watch VPN {
        pidfile = "/var/run/vpnc/pid"
}

tztime local {
        format = "%Y-%m-%d %H:%M:%S"
}

load {
        format = "%1min %5min %15min"
}

disk "/" {
        format = "%free (%avail) / %total"
}

volume master {
    format = "♪ %volume"
    device = "default"
    mixer = "Master"
    mixer_idx = 0
}'
