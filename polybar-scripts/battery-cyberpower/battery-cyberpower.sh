#!/bin/sh

IconAC='#1'
IconBatFull='#21'
IconBatGood='#22'
IconBatLow='#23'
IconBatCaution='#24'
IconBatEmpty='#25'

ShowEst=1

BatPrint() {
    BatInfo=$(sudo pwrstat -status)
    BatCap=$(printf '%s\n' "$BatInfo" | awk '/Capacity/{print $3}')
    BatAC=$(printf '%s\n' "$BatInfo" | awk '/Power Supply by/{print $4,$5}')
    BatLoad=$(printf '%s\n' "$BatInfo" | grep 'Load' | cut -d '(' -f 2 | tr -d ' %)')
    BatRemain=$(printf '%s\n' "$BatInfo" | awk '/Remaining Runtime/{print $3}')

    Output=''

    if [ "$BatAC" = 'Utility Power' ]; then
        if [ $BatCap -gt 97 ]; then
            Output=$IconAC
        else
            Output="$IconAC $BatCap %"
        fi
    else
        if [ $BatCap -gt 85 ]; then
            Output="$IconBatFull $BatCap %"
        elif [ $BatCap -gt 60 ]; then
            Output="$IconBatGood $BatCap %"
        elif [ $BatCap -gt 35 ]; then
            Output="$IconBatLow $BatCap %"
        elif [ $BatCap -gt 10 ]; then
            Output="$IconBatCaution $BatCap %"
        else
            Output="$IconBatEmpty $BatCap %"
        fi
    fi

    if [ "$ShowEst" -eq 1 ]; then
        Output="$Output ($BatLoad % / $BatRemain min)"
    fi

    printf '%s\n' "$Output"
}

trap exit INT
trap "printf '\n'" USR1

while true; do
    BatPrint "$@"

    sleep 30 &
    wait
done
