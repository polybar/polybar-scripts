#!/bin/sh

updates=0
if [ -n "$(which yay 2> /dev/null)" ]; then
    updates=$(yay -Qu --repo --quiet | wc -l)
elif [ -n "$(which checkupdates 2> /dev/null)" ]; then
    updates=$(checkupdates | wc -l)
else
    updates=$(pacman -Qu --quiet | wc -l)
fi

if [ "$updates" -gt 0 ]; then
    echo "# $updates"
else
    echo ""
fi
