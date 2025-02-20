#!/bin/sh

ENDPOINT="http://pi.hole/admin/api.php" # Pi-Hole API endpoint. Change host
API_TOKEN="" # Get from /admin/settings/api under "Expert" -> "Advanced Settings" -> "Configure app password"
# NOTE: You may want to increase webserver.api.max_sessions (in /admin/settings/all)

DISABLE_TIME="300" # In seconds. Set to 0 to disable Pi-Hole forever
REFRESH_INTERVAL="10" # In seconds. Set to "infinity" to disable refreshing

ON_LABEL="󰷱"
OFF_LABEL="%{F#f00}󰷱%{F-}"


get_sid() {
  if [ -n "$session_validity" ] && [ "$session_validity" -gt "$(date +%s)" ]; then
    echo "$session_sid"
    return
  fi
  
  local response=$(curl -k -s -X POST "$ENDPOINT/auth" --data "{\"password\":\"$API_TOKEN\"}")
  session_sid=$(echo "$response" | jq -r '.session.sid')
  session_validity=$(($(date +%s) + $(echo "$response" | jq -r '.session.validity')))
  echo "$session_sid"
}

get_status() {
  curl -k -s -H "X-FTL-SID: $(get_sid)" "$ENDPOINT/dns/blocking" | jq -r '.blocking'
}

sleep_pid=0

toggle() {
    status="$(get_status)"

    case "$status" in
        enabled)
            curl -k -s -H "X-FTL-SID: $(get_sid)" -X POST "$ENDPOINT/dns/blocking" --data "{\"blocking\":false,\"timer\":$DISABLE_TIME}" > /dev/null
            echo "$OFF_LABEL"
            sleep 0.1 # some time for write to finish before refetch
            ;;
        disabled)
            curl -k -s -H "X-FTL-SID: $(get_sid)" -X POST "$ENDPOINT/dns/blocking" --data "{\"blocking\":true}" > /dev/null
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
