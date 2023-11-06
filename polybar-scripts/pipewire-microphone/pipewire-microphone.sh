#!/bin/sh

get_mic_default() {
    pactl info | awk '/Default Source:/ {print $3}'
}

is_mic_muted() {
    pactl get-source-mute "$(get_mic_default)" | awk '{print $2}'
}

get_mic_status() {
    if [ "$(is_mic_muted)" = "yes" ]; then
        printf "%s\n" "#1"
    else
        printf "%s\n" "#2"
    fi
}

listen() {
    get_mic_status
    LANG=EN; pactl subscribe | while read -r event; do
        if printf "%s\n" "${event}" | grep -qE '(source|server)'; then
            get_mic_status
        fi
    done
}

toggle() {
    pactl set-source-mute @DEFAULT_SOURCE@ toggle
}

case "${1}" in
    --toggle)
        toggle
        ;;
    *)
        listen
        ;;
esac
