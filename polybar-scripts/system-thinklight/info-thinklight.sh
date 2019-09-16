#!/bin/sh

if [ "$(cat /sys/devices/platform/thinkpad_acpi/leds/tpacpi::thinklight/brightness)" = "0" ]; then
    echo "#1"
else
    echo "#2 Thinklight"
fi
