#!/bin/bash

c=0;
t=0;

for i in $( awk '/MHz/ {print $4}' < /proc/cpuinfo )
do
    t=$( echo "$t + $i" | bc )
    ((c++))
done
echo "scale=2; $t / $c / 1000" | bc | awk '{print $1" GHz"}'
