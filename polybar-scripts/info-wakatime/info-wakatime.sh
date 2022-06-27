#!/bin/sh
TOKEN=""

wakatime_today="$(curl -sf --header "Authorization: Basic $(echo "$TOKEN" | base64)" https://wakatime.com/api/v1/users/current/status_bar/today | jq -r '.data.grand_total.text')"

if [ -n "$wakatime_today" ]; then
    echo "#1 $wakatime_today"
else
    echo "#2"
fi
