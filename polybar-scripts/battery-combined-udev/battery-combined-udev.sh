#!/bin/sh

battery_print() {
    PATH_ACs=$(find /sys/class/power_supply/ -regex ".*A\(C\|DP\)0")
    PATH_BATTERIES=$(find /sys/class/power_supply/*)

    ac=0
    battery_level=0
    battery_max=0

    for PATH_AC in $PATH_ACs; do
        if [ -f "$PATH_AC/online" ]; then
            ac=$(("$ac + $(cat "$PATH_AC/online")"))
        fi
    done;

    for PATH_BATTERY in $PATH_BATTERIES; do
        if [ -f "$PATH_BATTERY/energy_now" ]; then
            battery_level=$(("$batteries_level + $(cat "$PATH_BATTERY/energy_now")"))
        fi

        if [ -f "$PATH_BATTERY/energy_full" ]; then
            battery_max=$(cat "$PATH_BATTERY/energy_full")
        fi
    done;

    battery_percent=$(("$battery_level * 100"))
    battery_percent=$(("$battery_percent / $battery_max"))

    if [ "$ac" -gt 0 ]; then
        icon="#1"

        if [ "$battery_percent" -gt 97 ]; then
            echo "$icon"
        else
            echo "$icon $battery_percent %"
        fi
    else
        if [ "$battery_percent" -gt 85 ]; then
            icon="#21"
        elif [ "$battery_percent" -gt 60 ]; then
            icon="#22"
        elif [ "$battery_percent" -gt 35 ]; then
            icon="#23"
        elif [ "$battery_percent" -gt 10 ]; then
            icon="#24"
        else
            icon="#25"
        fi

        echo "$icon $battery_percent %"
    fi
}

path_pid="/tmp/polybar-battery-combined-udev.pid"

case "$1" in
    --update)
        pid=$(cat $path_pid)

        if [ "$pid" != "" ]; then
            kill -10 "$pid"
        fi
        ;;
    *)
        echo $$ > $path_pid

        trap exit INT
        trap "echo" USR1

        while true; do
            battery_print

            sleep 30 &
            wait
        done
        ;;
esac
