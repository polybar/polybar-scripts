#!/bin/sh

sink=0

volume_up() {
    pactl set-sink-volume $sink +1%
}

volume_down() {
    pactl set-sink-volume $sink -1%
}

volume_mute() {
    pactl set-sink-mute $sink toggle
}

volume_print() {
    if pacmd list-sinks | grep active | head -n 1 | grep -q speaker; then
        icon="#1"
    elif pacmd list-sinks | grep active | head -n 1 | grep headphones; then
        icon="#2"
    else
        icon="#3"
    fi

    muted=$(pamixer --sink $sink --get-mute)

    if [ "$muted" = true ]; then
        echo "$icon --"
    else
        echo "$icon $(pamixer --sink $sink --get-volume)"
    fi
}

listen() {
    volume_print

    pactl subscribe | while read -r event; do
        if echo "$event" | grep -q "#$sink"; then
            volume_print
        fi
    done
}

case "$1" in
    --up)
        volume_up
        ;;
    --down)
        volume_down
        ;;
    --mute)
        volume_mute
        ;;
    *)
        listen
        ;;
esac
