#!/bin/sh

hackspeed_cache="$HOME/.config/polybar/info-hackspeed.cache"

echo "" > $hackspeed_cache
xinput test "AT Translated Set 2 keyboard" | grep --line-buffered -o "key press" >> $hackspeed_cache &

while true; do
    sleep 20

    lines=$(cat $hackspeed_cache | wc -l)
    lines=$((($lines - 1) * 3))

    echo "" > $hackspeed_cache
    echo "#  $lines"
done
