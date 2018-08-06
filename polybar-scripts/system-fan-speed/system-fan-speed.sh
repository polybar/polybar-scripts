#!/bin/sh

speed=$(sensors | grep fan1 | cut -d " " -f 9)

if [ "$speed" != "" ]; then
    speed_round=$(echo "scale=1;$speed/1000" | bc -l )
    echo "# $speed_round"
else
   echo "#"
fi
