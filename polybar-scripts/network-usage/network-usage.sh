#!/bin/bash

units() {
    if [ "$1" -eq 0 ] || [ "$1" -lt 1000 ]; then
        bytes="0 kB/s"
    elif [ "$1" -lt 1000000 ]; then
        bytes="$(echo "scale=0;$1/1000" | bc -l ) KB"
    else
        bytes="$(echo "scale=1;$1/1000000" | bc -l ) MB"
    fi

    echo "$bytes"
}

interface=$(ip route | grep -oPm1 "(?<=dev )[^ ]+")
declare -A bytes

down=$(cat /sys/class/net/"$interface"/statistics/rx_bytes)
up=$(cat /sys/class/net/"$interface"/statistics/tx_bytes)

case $1 in
    total)
        echo "$(units $(( up+down )))" ;;
    split)
        echo "$(units $down)/$(units $up)" ;;
esac

