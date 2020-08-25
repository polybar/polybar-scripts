#!/bin/sh

speed=$(sensors | grep fan1 | awk '{print $2; exit}')

if [ "$speed" != "" ]; then
    speed_round=$(echo "scale=1;$speed/1000" | bc -l )
    echo "# $speed_round"
else
   echo "#"
fi
