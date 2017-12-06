#!/bin/sh

url="your url here"

# Set prefix icon
icon="# "

# Set prefix icon color with and without unread messages
color_read="#e0e0e0"
color_unread="#e06c75"

unread=$(curl -s "$url" | jq '.["data"]["children"] | length ')

if [ "$unread" -gt 0 ]; then
   echo "%{F$color_unread}$icon $unread"
else
   echo "%{F$color_read}$icon $unread"
fi
