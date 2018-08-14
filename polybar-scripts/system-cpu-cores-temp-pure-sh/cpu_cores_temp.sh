#!/bin/sh

WARN_TEMP=50
WARN_COLOR='#AC3C71'

for t in `cat /sys/devices/platform/coretemp.0/hwmon/hwmon0/temp?_input`; do 
	t=${t%000}
	if [ $t -gt $WARN_TEMP ]; then
		echo -n '%{F'$WARN_COLOR'}'$t'˚ '%{F-};
	else
		echo -n $t'˚ ';
	fi
done; 

echo

