#!/bin/sh

ICON_AC="#1"
ICON_BATTERY_FULL="#21"
ICON_BATTERY_GOOD="#22"
ICON_BATTERY_LOW="#23"
ICON_BATTERY_CAUTION="#24"
ICON_BATTERY_EMPTY="#25"

battery_print() {
    battery_info="$(sudo pwrstat -status)"
    battery_status="$(echo "$battery_info" | awk '/State/{print $3,$4}')"
    battery_capacity="$(echo "$battery_info" | awk '/Capacity/{print $3}')"
    battery_ac="$(echo "$battery_info" | awk '/Power Supply by/{print $4,$5}')"
    battery_load="$(echo "$battery_info" | grep "Load.." | cut -d\( -f2- | cut -d\) -f1 | tr -d ' %')"
    battery_remaining="$(echo "$battery_info" | grep "Remaining Runtime" | cut -d\  -f3-)"

    show_estimation=0
    if [ "$1" == "--show-estimation" ]; then
        show_estimation=1
    fi

    ac=0

    if [ "$battery_ac" == "Utility Power" ]; then
        ac=1
    fi

    if [ "$ac" -eq 1 ]; then
        icon="$ICON_AC"

        if [ "$battery_capacity" -gt 97 ]; then
            echo -n "$icon"
        else
            echo -n "$icon $battery_capacity %"
        fi
    else
        if [ "$battery_capacity" -gt 85 ]; then
            icon="$ICON_BATTERY_FULL"
        elif [ "$battery_capacity" -gt 60 ]; then
            icon="$ICON_BATTERY_GOOD"
        elif [ "$battery_capacity" -gt 35 ]; then
            icon="$ICON_BATTERY_LOW"
        elif [ "$battery_capacity" -gt 10 ]; then
            icon="$ICON_BATTERY_CAUTION"
        else
            icon="$ICON_BATTERY_EMPTY"
        fi

        echo -n "$icon $battery_capacity %"
    fi
    if [ "$show_estimation" -eq 1 ]; then
        echo " ($battery_load % / $battery_remaining)"
    else
        echo ""
    fi
}

trap exit INT
trap "echo" USR1

while true; do
    battery_print "$@"

    sleep 30 &
    wait
done
