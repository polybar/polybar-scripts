#!/usr/bin/env bash

function listPlayers {
    echo "$(dbus-send --session --dest=org.freedesktop.DBus \
        --type=method_call --print-reply /org/freedesktop/DBus \
        org.freedesktop.DBus.ListNames | grep org.mpris.MediaPlayer2 |
        awk -F\" '{print $2}' | cut -d '.' -f4- )"
}

function getPlayerStatus {
    playerctl --player="$1" status
}

function getActivePlayer {
    players=($(listPlayers))
    for player in ${players[@]}; do
        if [ "$(getPlayerStatus "${player}")" == "Playing" ]; then
            playing=$player
	fi
    done
    for player in ${players[@]}; do
        if [ "$(getPlayerStatus "${player}")" == "Paused" ]; then
            paused=$player
	fi
    done
    if [ -n "$playing" ]; then
        echo "$playing"
    elif [ -n "$paused" ]; then
        echo "$paused"
    else
	# Return last (newest?) player
        echo ${players[@]: -1}
    fi
}

if [ "$1" == "--get-active" ]; then
  getActivePlayer
else
  exec playerctl --player="$(getActivePlayer)" "$@"
fi
