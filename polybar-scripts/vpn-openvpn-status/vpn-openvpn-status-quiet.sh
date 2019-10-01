#!/bin/sh

VPN_CONNECTION=$(pgrep -a openvpn$ | head -n 1 | awk '{print $NF }' | cut -d '.' -f 1)
if test -n "$VPN_CONNECTION"; then
	echo "VPN: $VPN_CONNECTION"
fi
