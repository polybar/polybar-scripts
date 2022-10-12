#!/bin/sh

muted=$(pamixer --sink 0 --get-mute)

if [ "$muted" = true ]; then
    echo "#1 --"
else
    volume=$(pamixer --sink 0 --get-volume)

    if [ "$volume" -gt 49 ]; then
        echo "#2 $volume %"
    else
        echo "#3 $volume %"
    fi
fi
