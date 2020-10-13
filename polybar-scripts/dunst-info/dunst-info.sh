#!/bin/sh

ON="#1"  # Define icon/label for when notifications are ON
OFF="#2" # Define icon/label for when notifications are OFF

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
    sleep 1 & # Sleep time can be increased if dunstctl is never/rarely executed manually.
    wait
done
