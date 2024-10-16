#!/bin/sh

ENDPOINT="http://pi.hole/admin/api.php" # Pi-Hole API endpoint. Change host
API_TOKEN="" # Get from /admin/settings.php?tab=api

DISABLE_TIME="300" # In seconds. Set to 0 to disable Pi-Hole forever
REFRESH_INTERVAL="10" # In seconds. Set to "infinity" to disable refreshing

# Uses Nerd Fonts for icon and lemonbar tags for coloring
ON_LABEL="󰷱"
OFF_LABEL="%{F#f00}󰷱%{F-}"


get_status() {
  curl -s "$ENDPOINT?status&auth=$API_TOKEN" | jq -r '.status'
}

sleep_pid=0

toggle() {
    status="$(get_status)"

    case "$status" in
        enabled)
            curl -s "$ENDPOINT?disable=$DISABLE_TIME&auth=$API_TOKEN" > /dev/null
            echo "$OFF_LABEL"
            sleep 0.1 # some time for write to finish before refetch
            ;;
        disabled)
            curl -s "$ENDPOINT?enable&auth=$API_TOKEN" > /dev/null
            echo "$ON_LABEL"
            sleep 0.1 # some time for write to finish before refetch
            ;;
    esac

    if [ "$sleep_pid" -ne 0 ]; then
        kill $sleep_pid >/dev/null 2>&1
    fi
}

trap "toggle" USR1

while true; do
    status="$(get_status)"

    case "$status" in
        enabled)
            echo "$ON_LABEL"
            ;;
        disabled)
            echo "$OFF_LABEL"
            ;;
    esac

    sleep "$REFRESH_INTERVAL" &
    sleep_pid=$!
    wait
done
