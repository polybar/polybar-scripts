#!/bin/sh

if timew > /dev/null 2>&1; then
    timew summary :day | awk '{print $NF}' | tail -2 | head -1
else
    printf "no tracking"
fi

if "${1}" -eq "--toggle"; then
    if timew; then
        timew stop;
    else
        timew start;
    fi
fi
