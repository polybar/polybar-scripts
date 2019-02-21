#!/usr/bin/env bash
#
# If `xbps-install -Sun` returns an error saying it failed to initialize libxbps
# you may need to add this script to your sudoers file so you can run it with sudo

updates=$(/usr/bin/xbps-install -Sun 2> /dev/null | wc -l)

if [[ -z $updates ]] || [[ $updates -eq '0' ]]; then
    exit 1
#elif (( $updates > 99 )); then
#    updates='99+'
fi

echo $updates
exit 0
