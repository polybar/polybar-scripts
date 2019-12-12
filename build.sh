#!/bin/sh

error_count=0
scripts="polybar-scripts/*/*.sh"

for file in $scripts; do
    if ! shellcheck "$file"; then
        error_count=$((error_count+1))
    fi
done

if [ $error_count -eq 0 ]; then
    exit 0
else
    exit 1
fi
