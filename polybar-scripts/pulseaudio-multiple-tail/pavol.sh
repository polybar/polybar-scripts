#!/bin/sh
case "$1" in
    -i)
        if [[ $(pamixer --sink $2 --get-volume) -le 94 ]]
        then
            pactl set-sink-volume $2 +5%
        else
            pactl set-sink-volume $2 100%
        fi
        ;;
    -d)
        pactl set-sink-volume $2 -5%
        ;;
    -m)
        pactl set-sink-mute $2 toggle 
        ;;
    *)
        echo ""
esac
