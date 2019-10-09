#!/usr/bin/env bash

SOCKET_PATH=/tmp/mpvsocket

get_property () {
  echo '{ "command": ["get_property", "'$1'"] }' | socat $SOCKET_PATH -
}

set_property () {
  xargs -i echo '{ "command": ["set_property", "'$1'", {}] }' | socat $SOCKET_PATH -
}

playlist_pos () {
  get_property playlist-pos | jq ".data $1= 1 | .data" | set_property playlist-pos
}

time_pos () {
  get_property time-pos | jq ".data |= .$1 | .data" | set_property time-pos
}

case $1 in
  -time)
    time_pos $2
    ;;
  -pause)
    get_property pause | jq '.data | not' | set_property pause
    ;;
  -prev)
    playlist_pos -
    ;;
  -next)
    playlist_pos +
    ;;
esac
