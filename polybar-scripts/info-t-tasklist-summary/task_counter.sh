#!/bin/bash

tskfile="$HOME/tasks/tasks"
task_cats=$(cut -d':' -f1 "$tskfile"| sort | uniq -c | sort -n)
total=$(wc -l "$tskfile")
outp="Tasks:$total|"
while read -r catg; do
    catg=$(echo "$catg" | cut -d' ' -f2)
    count=$(grep "^$catg" "$tskfile" | wc -l | cut -d' ' -f2)
    outp+="$catg:$count|"
done <<< "$task_cats"
echo "${outp::-1}|"
