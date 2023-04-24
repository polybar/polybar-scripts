#!/bin/sh
routedefault=$(ip r | grep -c default)

if [ "$routedefault" -eq 1 ]; then
updates=$(sudo dnf updateinfo -q --list | wc -l)
    
    if [ "$updates" -gt 0 ]; then
        echo " $updates"
    else
        echo ""
    fi
else
    echo "No Internet"
fi

