#!/bin/sh

# Your chess.com username
username="your username here"
games=$(curl -s "https://api.chess.com/pub/player/$username/games/to-move" | jq ".[] | length")

if [ "$games" -gt 0 ]; then
   echo "#1 $games"
else
   echo "#2"
fi
