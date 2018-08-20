#! /bin/sh
yay -Qu | awk '{print $1;}' | sed 's/\x1b\[[0-9;]*m//g' | xargs -0 notify-send -t 10000 --hint=int:suppress-sound:0 "Pending Package Updates"
