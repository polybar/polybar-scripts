#!/bin/sh

duetoday=$(grep -c "$(date -I)" ~/todo.txt)
dueweek=0
weekday=0

while [ "$weekday" -le 7 ]; do
    dueweek=$((dueweek + $(grep -c "$(date -I --date="$weekday day")" ~/todo.txt)))
    weekday=$(( weekday + 1 ))
done

if [ "$dueweek" -gt 0 ]; then
   echo "#1 $duetoday $dueweek"
else
   echo "#2" 
fi