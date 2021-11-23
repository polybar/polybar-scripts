#!/bin/sh

get_mic_default() {
    pw-cat --record --list-targets | sed -n -E "1 s/^.*: (.*)/\1/p"
}

is_mic_muted() {
    mic_name="$(get_mic_default)"

    pactl list sources | \
        awk -v mic_name="${mic_name}" '{
            if ($0 ~ "Name: " mic_name) {
                matched_mic_name = 1;
            } else if (matched_mic_name && /Mute/) {
                print $2;
                exit;
            }
        }'
}

get_mic_status() {
    is_muted="$(is_mic_muted)"

    if [ "${is_muted}" = "yes" ]; then
        printf "%s\n" "#1"
    else
        printf "%s\n" "#2"
    fi
}

listen() {
    get_mic_status

    LANG=EN; pactl subscribe | while read -r event; do
        if printf "%s\n" "${event}" | grep --quiet "source" || printf "%s\n" "${event}" | grep --quiet "server"; then
            get_mic_status
        fi
    done
}

toggle() {
    pactl set-source-mute @DEFAULT_SOURCE@ toggle
}

case "$1" in
    --toggle)
        toggle
        ;;
    *)
        listen
        ;;
esac
