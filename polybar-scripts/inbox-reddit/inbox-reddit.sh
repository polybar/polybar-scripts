#!/bin/bash

url="your url here"

# Set prefix icon
icon="# "

# Set prefix icon color with and without unread messages
unread_color="#e06c75"
read_color="#e0e0e0"

unread=$(curl -s "$url" | jq '.["data"]["children"] | length ')
(( "$unread" > "0" )) && echo "%{F$unread_color}$icon $unread" || echo "%{F$read_color}$icon $unread"
