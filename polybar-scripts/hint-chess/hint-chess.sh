#!/bin/sh

# Your chess.com username
username="your username here"

# Set prefix icon
icon="# "

# Set prefix icon color
color_games="#e06c75"
color_nogames="#e0e0e0"

games=$(curl -s "https://api.chess.com/pub/player/$username/games/to-move" | jq ".[] | length")

if [ "$games" -gt 0 ]; then
   echo "%{F$color_games}$icon $games"
else
   echo "%{F$color_nogames}$icon $games"
fi
