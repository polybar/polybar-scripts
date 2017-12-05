#!/bin/sh

updates_arch=$(checkupdates | wc -l)

if ! updates_aur=$(trizen -Su --aur 2> /dev/null); then
    updates_aur=0
else
    updates_aur=$(echo $updates_aur | wc -l)
fi

updates=$(("$updates_arch" + "$updates_aur"))

if [ "$updates" -gt 0 ]; then
    echo "# $updates"
else
    echo ""
fi
