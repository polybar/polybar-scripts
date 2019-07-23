#!/bin/sh

DATE="$(date +"%a %d %H:%M")"

case "$1" in
--popup)
    if [ "$(xdotool getwindowfocus getwindowname)" = "yad-calendar" ]; then
        exit 0
    fi

    yad --calendar --undecorated --fixed --close-on-unfocus --no-buttons \
        --mouse \
        --title="yad-calendar" >/dev/null &
    ;;
*)
    echo "$DATE"
    ;;
esac
