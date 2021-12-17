#! /usr/bin/env bash

sleep_pid=0

layout=$(setxkbmap -query | grep layout | awk '{print $2}')

toggle() {
    layout=$(setxkbmap -query | grep layout | awk '{print $2}')
    if [ "$layout" = "fr" ]; then
        layout="us"
    elif [ "$layout" = "us" ]; then
        layout="fr"
    fi
    if [ "$sleep_pid" -ne 0 ]; then
        kill $sleep_pid >/dev/null 2>&1
    fi
}

trap "toggle" USR1

while true; do
    setxkbmap "$layout" -model pc105
    echo " $layout"
    sleep 1 &
    sleep_pid=$!
    wait
done
