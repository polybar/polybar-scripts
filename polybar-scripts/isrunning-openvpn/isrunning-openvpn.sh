#!/bin/sh

if [ "$(pgrep openvpn)" ]; then
    echo "#1"
else
    echo "#2"
fi
