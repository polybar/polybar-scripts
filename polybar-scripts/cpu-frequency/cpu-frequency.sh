#!/usr/bin/env sh

frequency=$(lscpu | awk '/CPU MHz/ {print $3}' | sed 's/\.[0-9]*//g')
if [ "$frequency" -gt "$(lscpu | awk '/CPU max MHz/ {print $4}' | sed 's/\.[0-9]*//g')" ]; then
    BOOSTED='+'
fi
printf "%-9s\n" "$(printf "%.2e" "0.$frequency" | sed 's/e.*//g') GHz${BOOSTED}"

