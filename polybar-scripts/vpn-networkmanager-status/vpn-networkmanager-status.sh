#!/bin/bash

# Define Status Messages
disconnectedMessage="#1 VPN: DOWN"
connectedMessagePreamble="#2 VPN:"

# Acquire raw output of status
connectionName="$(nmcli c show --active | grep -Eo '^[^ ]+' | grep -v NAME | head -1)"
active="$(nmcli c show --active | grep tun | head -1)"
# Check to see if the VPN is active; done by checking whether "tun" is an active interface
if [ -n "$active" ]
then
	connectedMessage="$connectedMessagePreamble $connectionName"
	echo "$connectedMessage"
else
	echo "$disconnectedMessage"
fi

