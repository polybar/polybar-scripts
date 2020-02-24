#!/bin/sh

PathAC='/sys/class/power_supply/AC'
PathBat0='/sys/class/power_supply/BAT0'
PathBat1='/sys/class/power_supply/BAT1'

AC=0
BatLvl_0=0
BatLvl_1=0
BatMax_0=0
BatMax_1=0

[ -f "$PathAC/online" ] && read AC < "$PathAC/online"
[ -f "$PathBat0/energy_now" ] && read BatLvl_0 < "$PathBat0/energy_now"
[ -f "$PathBat0/energy_full" ] && read BatMax_0 < "$PathBat0/energy_full"
[ -f "$PathBat1/energy_now" ] && read BatLvl_1 < "$PathBat1/energy_now"
[ -f "$PathBat1/energy_full" ] && read BatMax_1 < "$PathBat1/energy_full"

BatLvl=$((BatLvl_0 + BatLvl_1))
BatMax=$((BatMax_0 + BatMax_1))

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
        Icon='#25'
    fi

    printf '%s %d %%\n' "$Icon" "$BatPerc"
fi
