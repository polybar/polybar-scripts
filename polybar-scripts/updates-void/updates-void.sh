#!/bin/sh

if ! updates=$(/usr/bin/xbps-install -Sun 2> /dev/null | wc -l); then
    updates=0
fi

if [ "$updates" -gt 0 ]; then
    echo "# $updates"
else
    echo ""
fi
