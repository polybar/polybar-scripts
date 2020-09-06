#!/bin/sh

ON=""
OFF=""

toggle() {
    paused=$(dunstctl is-paused)
    if [ "$paused" = "true" ]
    then
        echo "$OFF"
    else
        echo "$ON"
    fi
}


trap "toggle" USR1

while true; do
    toggle
    sleep 1 &
    wait
done
