#!/bin/sh

MATTERMOST_SERVER="https://mattermost-server.net"
MATTERMOST_TOKEN=""

notifications=$(curl -sf -H "Authorization: Bearer $MATTERMOST_TOKEN" "$MATTERMOST_SERVER/api/v4/users/me/teams/unread")

notifications_msg=$(echo "$notifications"  | jq -s 'map(.[].msg_count) | add')
notifications_mention=$(echo "$notifications"  | jq -s 'map(.[].mention_count) | add')

echo "# $notifications_msg / $notifications_mention"
