#!/bin/sh

pkcon refresh >/dev/null 2>&1

updates=$(apt list --upgradable 2> /dev/null | grep -c upgradable);

if [ "$updates" -gt 0 ]; then
    echo "# $updates"
else
    echo ""
fi
