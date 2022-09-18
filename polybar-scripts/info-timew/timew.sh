#!/bin/bash

if timew > /dev/null 2>&1; then
    timew summary :day | awk '{print $NF}' | tail -2 | head -1
else
    echo -e "no tracking"
fi