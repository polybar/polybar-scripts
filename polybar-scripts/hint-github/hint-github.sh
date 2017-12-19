#!/bin/sh

TOKEN="1234567890"

notifications=$(curl -fs https://api.github.com/notifications?access_token=$TOKEN | jq ".[].unread" | grep -c true)

if [ "$notifications" -gt 0 ]; then
    echo "# $notifications"
else
    echo ""
fi
