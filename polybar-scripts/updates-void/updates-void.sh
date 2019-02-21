#!/bin/sh
#
# If `xbps-install -Sun` returns an error saying it failed to initialize libxbps
# you may need to add this script to your sudoers file so you can run it with sudo

if ! updates=$(/usr/bin/xbps-install -Sun 2> /dev/null | wc -l); then
    updates=0
fi

if [ "$updates" -gt 0 ]; then
    echo "# $updates"
else
    echo ""
fi
