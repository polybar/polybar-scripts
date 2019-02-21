#!/usr/bin/env bash

# Count staged updates
count=$(dnf check-update --refresh -q | awk NF | wc -l)

# Check if staged updates are actual upgrades yet
# to make this part work, add:
#
# %users ALL=(ALL) NOPASSWD:/usr/bin/dnf upgrade
#
# to /etc/sudoers

(sudo dnf upgrade --refresh --assumeno | grep -q "Nothing")
can_update=$?

# Change the status color
if [ "$can_update" -eq 0 ]; then
    # Updates are not available yet, they're only staged
    # -> red light
    color="a62a23"
else
    # Updates are completely available!
    # -> green light
    color="23a62a"
fi

if [ "$count" -eq 0 ]; then
    # No updates available at all, hide the module
    echo ""
else
    # Staged or "real" updates available, show module
    echo "%{F#$color} $count"
fi
