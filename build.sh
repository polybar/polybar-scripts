#!/bin/sh

error_count=0
scripts="polybar-scripts/*/*.sh"

for file in $scripts; do

    # Exceptions
    if [ "$file" = "polybar-scripts/info-hackspeed/info-hackspeed.sh" ]; then
        shellcheck --exclude=SC2016,SC2059 "$file"
        if [ $? -ne 0 ]; then
            error_count=$((error_count+1))
        fi
    else
        shellcheck "$file"
        if [ $? -ne 0 ]; then
            error_count=$((error_count+1))
        fi
    fi
done

if [ $error_count -eq 0 ]; then
    exit 0
else
    exit 1
fi
