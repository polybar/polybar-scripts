#!/bin/sh

duetoday=$(grep "due:$(date -I)" ~/todo.txt | grep -c -v "x")
dueweek=0
weekday=0

while [ "$weekday" -le 7 ]; do
    dueweek=$((dueweek + $(grep "due:$(date -I --date="$weekday day")" ~/todo.txt | grep -c -v "x")))
    weekday=$(( weekday + 1 ))
done

if [ "$dueweek" -gt 0 ]; then
   echo "#1 $duetoday $dueweek"
else
   echo "#2" 
fi