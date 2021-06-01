#!/usr/bin/env bash
set -euo pipefail

# checking for one argument here
if [ $# -eq 1 ]; then
    # check if the argument is "toggle"
    if [[ "$1" == "toggle" ]]; then
        dunstctl set-paused toggle
    # exit if something else is provided
    else
        echo "Wrong argument. Use \"toggle\""
        $(exit 1); echo "$?"
    fi
# reject too many arguments
elif [ $# -ge 2 ]; then
    echo "Too many arguments provided"
    $(exit 1); echo "$?"
fi

# get the paused status of dunst
status="$(dunstctl is-paused)"

# if the status is false, dunst is paused
# notifications will wait until you reenable dunst
if [[ "$status" == "true" ]]; then
    echo -e "\uf1f6"
# if the status returned false, dunst is running and active.
# you can recieve notifications
elif [[ "$status" == "false" ]]; then
    echo -e "\uf0f3"
fi
