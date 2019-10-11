#!/bin/bash

if [ "$(bluetoothctl show | awk '/Powered/ { print $2 }')" == "no" ]
then
	bluetoothctl power on
	#bluetoothctl connect xx:xx:xx:xx:xx:xx (for fast connection)
else
	bluetoothctl power off
fi
