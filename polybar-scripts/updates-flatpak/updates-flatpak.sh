#!/bin/sh

# The first 3 lines and the 2 last lines in 'flatpak update' are garbage.
updates=$(echo "n" | flatpak update 2>/dev/null | tail -n +4 | head -n 2 | wc -l)
if [ "$updates" -gt 0 ]; then
    echo "flatpak: $updates"
else
    echo ""
fi
