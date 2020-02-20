#!/bin/bash

format() {
    if [ "$1" -eq 0 ] || [ "$1" -lt 1000 ]; then
        bytes="off"
    elif [ "$1" -lt 1000000 ]; then
        bytes="$(echo "scale=0;$1/1000" | bc -l ) KB"
    else
        bytes="$(echo "scale=1;$1/1000000" | bc -l ) MB"
    fi

    echo "$bytes"
}

interface=`ip route | grep -oPm1 "(?<=dev )[^ ]+"`
declare -A bytes
down_file=/sys/class/net/"$interface"/statistics/rx_bytes
up_file=/sys/class/net/"$interface"/statistics/tx_bytes
if [ -f $down_file ];then
    down=$(cat $down_file)
    up=$(cat $up_file)
else
    down=0
    up=0
fi

case $1 in
    total)
        echo $(format $(( up+down ))) ;;
    split)
        echo $(format $down)/$(format $up) ;;
esac

