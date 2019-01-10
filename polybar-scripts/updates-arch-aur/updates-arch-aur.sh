#!/bin/sh

if ! updates=$(yay -Qum 2> /dev/null | wc -l); then
# if ! updates=$(cower -u 2> /dev/null | wc -l); then
# if ! updates=$(trizen -Su --aur --quiet | wc -l); then
    updates=0
fi

if [ "$updates" -gt 0 ]; then
    echo "# $updates"
else
    echo ""
fi
