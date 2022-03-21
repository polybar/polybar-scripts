#!/bin/sh

function main() {
    DEFAULT_SOURCE=$(pw-record --list-targets | sed -n 's/^*[[:space:]]*[[:digit:]]\+: source description="\(.*\)" prio=[[:digit:]]\+$/\1/p')
    DEFAULT_SINK=$(pw-play --list-targets | sed -n 's/^*[[:space:]]*[[:digit:]]\+: sink description="\(.*\)" prio=[[:digit:]]\+$/\1/p')
    VOLUME=$(pamixer --get-volume-human)

    case $1 in
        "up")
            pamixer --increase 10
            ;;
        "down")
            pamixer --decrease 10
            ;;
        "mute")
            pamixer --toggle-mute
            ;;
        *)
            echo "Source: ${DEFAULT_SOURCE} | Sink: ${VOLUME} ${DEFAULT_SINK}"
    esac
}

main "$@"
