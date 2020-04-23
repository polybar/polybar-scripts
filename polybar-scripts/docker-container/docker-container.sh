#!/usr/bin/env bash

# available container status:
#   created
#   restarting
#   running
#   removing
#   paused
#   exited
#   dead

status=(
  running
  exited
  dead
)

for stat in "${status[@]}"; do
  output+="$(docker ps -qf "status=$stat" | wc -l)|"

done

echo "|$output"

