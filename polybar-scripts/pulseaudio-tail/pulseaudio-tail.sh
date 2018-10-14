#!/bin/sh

### Leave this variable unset if you want to use the default sink
#sink=0

get_default_sink() {
    sink=$(pacmd list-sinks | sed -n '/\* index:/ s/.*: //p')
}

volume_up() {
    pactl set-sink-volume "$sink" +1%
}

volume_down() {
    pactl set-sink-volume "$sink" -1%
}

volume_mute() {
    pactl set-sink-mute "$sink" toggle
}

volume_print() {
    active_port=$(pacmd list-sinks | sed -n "/index: $sink/,/index:/p" | grep active)
    if echo "$active_port" | grep -q speaker; then
        icon="#1"
    elif echo "$active_port" | grep -q headphones; then
        icon="#2"
    else
        icon="#3"
    fi

    muted=$(pamixer --sink "$sink" --get-mute)

    if [ "$muted" = true ]; then
        echo "$icon --"
    else
        echo "$icon $(pamixer --sink "$sink" --get-volume)"
    fi
}

listen() {
    volume_print

    pactl subscribe | while read -r event; do
        if echo "$event" | grep -q "sink #$sink$"; then
            volume_print
        elif [ "$use_default_sink" ] && echo "$event" | grep -q "'change' on server"; then
            get_default_sink
            volume_print
        fi
    done
}

if [ -z "$sink" ]; then
    use_default_sink=true
    get_default_sink
fi
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
