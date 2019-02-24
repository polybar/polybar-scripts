#!/bin/sh

if sudo /usr/bin/xbps-install -S > /dev/null 2>&1; then
    updates=$(/usr/bin/xbps-install -un 2> /dev/null | wc -l)
fi

if [ -n "$updates" ] && [ "$updates" -gt 0 ]; then
    echo "# $updates"
else
    echo ""
fi
