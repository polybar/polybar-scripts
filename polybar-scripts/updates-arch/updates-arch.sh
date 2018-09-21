#!/bin/sh

# if ! updates=$(yay -Qu --repo --quiet 2> /dev/null | wc -l ); then
# if ! updates=$(pacman -Qu --quiet 2> /dev/null | wc -l ); then
if ! updates=$(checkupdates 2> /dev/null | wc -l ); then
    updates=0
fi

if [ "$updates" -gt 0 ]; then
    echo "# $updates"
else
    echo ""
fi
