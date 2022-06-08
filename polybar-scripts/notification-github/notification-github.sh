#!/bin/sh

USER="yourUserName"

# You can get your Personal access tokens from here : https://github.com/settings/tokens #
TOKEN="1234567890"

notifications=$(echo "user = \"$USER:$TOKEN\"" | curl -sf -K- https://api.github.com/notifications | jq ".[].unread" | grep -c true)

if [ "$notifications" -gt 0 ]; then
    echo " $notifications"
else
    echo " 0"
fi
