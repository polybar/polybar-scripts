#!/bin/sh

HOST=127.43.12.64

rtt=$(ping $HOST -c 1 | sed -rn 's/.*time=([0-9]{1,})\.?[0-9]{0,} ms.*/\1/p')

if [ "$rtt" -lt 50 ]; then
    icon="%{F#3cb703}#%{F-}"
elif [ "$rtt" -lt 150 ]; then
    icon="%{F#f9dd04}#%{F-}"
else
    icon="%{F#d60606}#%{F-}"
fi

echo "$icon $rtt ms"
