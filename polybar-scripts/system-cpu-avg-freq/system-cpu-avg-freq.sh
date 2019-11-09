#!/bin/bash

c=0;
t=0;

while read -r i
do
    t=$( echo "$t + $i" | bc )
    ((c++))
done < <( awk '/MHz/ {print $4}' < /proc/cpuinfo )
echo "scale=2; $t / $c / 1000" | bc | awk '{print $1" GHz"}'
