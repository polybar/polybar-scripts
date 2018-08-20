#!/bin/sh
# List all updates available from Yay (includes AUR)

# Sync package list first
yay -Sy > /dev/null

# Get list and count of updates
if ! updates=$(yay -Qu | wc -l); then
    updates=0
fi

# Print the available updates if more than 0
if [ "$updates" -gt 0 ]; then
    echo "  $updates"
else
    echo ""
fi
