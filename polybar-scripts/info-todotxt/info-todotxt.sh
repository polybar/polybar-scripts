#!/bin/sh

duetoday=$(grep -c "$(date -I)" ~/todo.txt)
dueweek=0

for i in $(echo {0..7}day); do
    dueweek=$((dueweek + $(grep -c "$(date -I --date="$i")" ~/todo.txt)))
done   

if [ "$dueweek" -gt 0 ]; then
   echo "#1 $duetoday $dueweek"
else
   echo "#2" 
fi