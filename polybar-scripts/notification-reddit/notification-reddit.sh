#!/bin/sh

URL=""
USERAGENT="polybar-scripts/notification-reddit:v1.0 u/reddituser"

notifications=$(curl -sf --user-agent "$USERAGENT" "$URL" | jq '.["data"]["children"] | length')

if [ -n "$notifications" ] && [ "$notifications" -gt 0 ]; then
    echo "#1 $notifications"
else
    echo "#2"
fi
