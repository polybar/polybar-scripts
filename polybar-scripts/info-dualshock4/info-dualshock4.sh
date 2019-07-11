#!/bin/sh

for i in /sys/class/power_supply/sony_controller_battery_*/capacity; do
    echo "# $(cat /sys/class/power_supply/sony_controller_battery_"$i"/capacity)%"
done
