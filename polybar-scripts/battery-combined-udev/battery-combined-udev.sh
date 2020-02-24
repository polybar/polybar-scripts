#!/bin/sh

BatPrint() {
    PathAC='/sys/class/power_supply/AC'
    PathBat0='/sys/class/power_supply/BAT0'
    PathBat1='/sys/class/power_supply/BAT1'

    AC=0
    BatLvl0=0
    BatLvl1=0
    BatMax0=0
    BatMax1=0

    [ -f "$PathAC/online" ] && read AC < "$PathAC/online"
    [ -f "$PathBat0/energy_now" ] && read BatLvl0 < "$PathBat0/energy_now"
    [ -f "$PathBat0/energy_full" ] && read BatMax0 < "$PathBat0/energy_full"
    [ -f "$PathBat1/energy_now" ] && read BatLvl1 < "$PathBat1/energy_now"
    [ -f "$PathBat1/energy_full" ] && read BatMax1 < "$PathBat1/energy_full"

    BatLvl=$((BatLvl0 + BatLvl1))
    BatMax=$((BatMax0 + BatMax1))

    BatPerc=$((BatLvl * 100))
    BatPerc=$((BatPerc / BatMax))

    if [ $AC -eq 1 ]; then
        Icon='#1'

        if [ $BatPerc -gt 97 ]; then
            printf '%s\n' "$Icon"
        else
            printf '%s %d %%\n' "$Icon" "$BatPerc"
        fi
    else
        if [ $BatPerc -gt 85 ]; then
            Icon='#21'
        elif [ $BatPerc -gt 60 ]; then
            Icon='#22'
        elif [ $BatPerc -gt 35 ]; then
            Icon='#23'
        elif [ $BatPerc -gt 10 ]; then
            Icon='#24'
        else
            Icon="#25"
        fi

        printf '%s %d %%\n' "$Icon" "$BatPerc"
    fi
}

PathPID='/tmp/polybar-battery-combined-udev.ProcID'

case $1 in
    --update)
        read ProcID < "$PathPID"
        [ -n "$ProcID" ] && kill -10 "$ProcID" ;;
    *)
        printf '%d' $$ > "$PathPID"

        trap exit INT
        trap 'echo' USR1

        while true; do
            BatPrint

            sleep 30 &
            wait
        done ;;
esac
