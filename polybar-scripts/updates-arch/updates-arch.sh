#!/bin/sh

updates=0
if [ -n "$(command -v yay)" ]; then
    updates=$(yay -Qu --repo --quiet | wc -l)
elif [ -n "$(command -v checkupdates)" ]; then
    updates=$(checkupdates 2> /dev/null | wc -l)
else
    updates=$(pacman -Qu --quiet | wc -l)
fi

if [ "$updates" -gt 0 ]; then
    echo "# $updates"
else
    echo ""
fi
