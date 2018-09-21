#!/bin/sh

# If you're using yay, you can uncomment the following line
# and comment the rest until line 22
# updates=$(yay -Qu --quiet | wc -l)

# If you do not have `pacman-contrib` installed:
# if ! updates_arch=$(pacman -Qu --quiet 2> /dev/null | wc -l ); then
if ! updates_arch=$(checkupdates 2> /dev/null | wc -l ); then
    updates_arch=0
fi

# if ! updates_aur=$(cower -u 2> /dev/null | wc -l); then
if ! updates_aur=$(trizen -Su --aur --quiet | wc -l); then
    updates_aur=0
fi

updates=$(("$updates_arch" + "$updates_aur"))

# Comment until here if using yay

if [ "$updates" -gt 0 ]; then
    echo "# $updates"
else
    echo ""
fi
