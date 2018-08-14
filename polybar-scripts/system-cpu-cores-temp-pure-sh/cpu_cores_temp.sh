#!/bin/sh

WARN_TEMP=35
WARN_COLOR='#AC3C71'

cat /sys/devices/platform/coretemp.0/hwmon/hwmon0/temp?_input | while read -r t; do 
	t=${t%000}
	if [ "$t" -gt $WARN_TEMP ]; then
		printf "%%{F$WARN_COLOR}%s˚ %%{F-}" "$t";
	else
		printf "%s˚ " "$t";
	fi
done; 

echo

