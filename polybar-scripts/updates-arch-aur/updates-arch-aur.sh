#!/bin/sh

if type "trizen" >/dev/null 2>&1; then
  updates=$(trizen -Su --aur --quiet | wc -l)
elif type "cower" >/dev/null 2>&1; then
  updates=$(cower -u 2> /dev/null | wc -l)
elif type "yay" >/dev/null 2>&1; then
  updates=$(yay -Qum | wc -l)
fi

if [ "$updates" -gt 0 ]; then
    echo "# $updates"
else
    echo ""
fi
