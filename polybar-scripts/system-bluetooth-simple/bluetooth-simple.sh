#!/bin/sh

# Check if a device is connected by bluetooth using bluetoothctl
info=$(bluetoothctl info | grep Device)

# Show some output when it is
if echo "$info" | grep -q "Device"; 
then
    # Connected to a device
    echo ' #1 '
else 
    # Not connected to a device, hide label
    echo ''
fi
