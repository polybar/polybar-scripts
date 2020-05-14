#!/bin/sh

updates=$(apt list --upgradable 2> /dev/null | grep upgradable | wc -l);

if [ "$updates" -gt 0 ]; then
    echo " $updates"
else
    echo ""
fi
