#!/bin/sh

ICON_AC="#1"
ICON_BATTERY_FULL="#21"
ICON_BATTERY_GOOD="#22"
ICON_BATTERY_LOW="#23"
ICON_BATTERY_CAUTION="#24"
ICON_BATTERY_EMPTY="#25"

SHOW_ESTIMATION=1

battery_print() {
    battery_info="$(sudo pwrstat -status)"
    battery_capacity="$(echo "$battery_info" | awk '/Capacity/{print $3}')"
    battery_ac="$(echo "$battery_info" | awk '/Power Supply by/{print $4,$5}')"
    battery_load="$(echo "$battery_info" | grep "Load" | cut -d \( -f 2 | tr -d ' %)')"
    battery_remaining="$(echo "$battery_info" | awk '/Remaining Runtime/{print $3}')"

    output=""

    if [ "$battery_ac" = "Utility Power" ]; then
        if [ "$battery_capacity" -gt 97 ]; then
            output="$ICON_AC"
        else
            output="$ICON_AC $battery_capacity %"
        fi
    else
        if [ "$battery_capacity" -gt 85 ]; then
            output="$ICON_BATTERY_FULL $battery_capacity %"
        elif [ "$battery_capacity" -gt 60 ]; then
            output="$ICON_BATTERY_GOOD $battery_capacity %"
        elif [ "$battery_capacity" -gt 35 ]; then
            output="$ICON_BATTERY_LOW $battery_capacity %"
        elif [ "$battery_capacity" -gt 10 ]; then
            output="$ICON_BATTERY_CAUTION $battery_capacity %"
        else
            output="$ICON_BATTERY_EMPTY $battery_capacity %"
        fi
    fi

    if [ "$SHOW_ESTIMATION" -eq 1 ]; then
        output="$output ($battery_load % / $battery_remaining min)"
    fi

    echo "$output"
}

trap exit INT
trap "echo" USR1

while true; do
    battery_print "$@"

    sleep 30 &
    wait
done
