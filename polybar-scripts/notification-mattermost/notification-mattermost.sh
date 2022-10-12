#!/bin/sh

MATTERMOST_SERVER="https://mattermost-server.net"
MATTERMOST_TOKEN=""

if notifications=$(curl -sf -H "Authorization: Bearer $MATTERMOST_TOKEN" "$MATTERMOST_SERVER/api/v4/users/me/teams/unread"); then
    notifications_msg=$(echo "$notifications"  | jq -s 'map(.[].msg_count) | add')
    notifications_mention=$(echo "$notifications"  | jq -s 'map(.[].mention_count) | add')

    if [ "$notifications_msg" -gt 0 ] || [ "$notifications_mention" -gt 0 ]; then
        echo "# $notifications_msg / $notifications_mention"
    else
        echo ""
    fi
fi
