#!/bin/sh

updates=$(echo 'n' | flatpak update 2>/dev/null | tail -n +5 | head -2 | wc -l)

if [ "$updates" -gt 0 ]; then
    echo "flatpak: $updates"
else
    echo ""
fi
