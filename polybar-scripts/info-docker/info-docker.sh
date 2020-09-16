#!/bin/sh

# available container states:
# created, restarting, running, removing, paused, exited, dead

STATUS="running exited dead"

for stat in $STATUS; do
    output="$output $(sudo docker ps -qf status="$stat" | wc -l) |"
done

echo "|$output"
