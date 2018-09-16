#!/bin/sh

updates=0
if [ -n "$(command -v yay)" ]; then
    if ! updates=$(yay -Qu --aur --quiet | wc -l); then
        updates=0
    fi
elif [ -n "$(command -v trizen)" ]; then
    if ! updates=$(trizen -Su --aur --quiet | wc -l); then
        updates=0
    fi
elif [ -n "$(command -v cower)" ]; then
    if ! updates=$(cower -u 2> /dev/null | wc -l); then
        updates=0
    fi
fi

if [ "$updates" -gt 0 ]; then
    echo "# $updates"
else
    echo ""
fi
