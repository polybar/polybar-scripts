#!/bin/env bash
IFS=$'\n'
out=""
if [[ ! "$1" =~ "-noprefix" ]]; then
    out="VPNs:";
fi;
for process in $(pgrep -a 'openvpn$'); do
    out="$out $(echo \\"$process\\" | grep -Po '(?<=--remote\ )(\S*)|(?<=--config\ )(.*)(?=\.conf|\.ovpn)' | xargs basename)"
done
echo "$out"
unset IFS
