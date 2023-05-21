#!/bin/sh

device="wlan0"
connection=$(nmcli device show $device | grep "GENERAL.CONNECTION:" | awk '{print $2}')

if [[ -n $connection ]]; then
    echo $connection
else
    echo "No WiFi Connection"
fi