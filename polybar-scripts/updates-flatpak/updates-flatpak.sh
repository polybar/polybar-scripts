#!/bin/sh

updates=$(flatpak update 2>/dev/null | tail -n +5 | grep -Ev "^$|^Proceed|^Nothing"|wc -l)

if [ "$updates" -gt 0 ]; then
    echo "flatpak: $updates"
else
    echo ""
fi
