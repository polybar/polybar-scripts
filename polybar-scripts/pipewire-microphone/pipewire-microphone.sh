#!/bin/sh

_get_mic_default() {
    pactl info | awk '/Default Source:/ {print $3}'
}

_is_mic_muted() {
    pactl get-source-mute "$(_get_mic_default)" | awk '{print $2}'
}

_get_mic_status() {
    if [ "$(_is_mic_muted)" = "yes" ]; then
        printf "%s\n" "#1"
    else
        printf "%s\n" "#2"
    fi
}

_listen() {
    _get_mic_status
    LANG=EN; pactl subscribe | while read -r event; do
        if printf "%s\n" "${event}" | grep -qE '(source|server)'; then
            _get_mic_status
        fi
    done
}

_toggle() {
    pactl set-source-mute @DEFAULT_SOURCE@ toggle
}

case "${1}" in
    --toggle)
        _toggle
        ;;
    *)
        _listen
        ;;
esac

# vim: ts=4 sw=4 et:
