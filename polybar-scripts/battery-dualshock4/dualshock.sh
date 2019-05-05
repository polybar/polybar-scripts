#!/bin/bash

if [ ! -f /sys/class/power_supply/sony_controller_battery_*/capacity ]; then
    echo ""
else
    cat /sys/class/power_supply/sony_controller_battery_*/capacity | tr -d '\n'
    echo "%"
fi
