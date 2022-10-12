#!/bin/sh

STATUS="created exited paused running unknown"

for stat in $STATUS; do
    output="$output $(podman ps -qf status="$stat" | wc -l) |"
done

echo "|$output"
