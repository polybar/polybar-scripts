#!/usr/bin/env bash

# In case we get throttled anyway, we try with a different service.
throttled() {
    response=$(curl -s -H "Accept: application/json" ifconfig.co/json)
    ip=$(echo $response | jq -r '.ip' 2>/dev/null)
    country=$(echo $response | jq -r '.country_iso' 2>/dev/null)

    if  [ -z "$ip" ] || echo $ip | grep -iq null; then

	return 1
    fi

    return 0
}

connected() {
    if [ -z "$(route | grep '^default' | grep -o '[^ ]*$')" ]; then
	echo 1; exit 1; 
    fi
    
    echo 0;
}


while :; do

    # We do not want to exceed the limit of API requests, so we check if there is actually any changes.
    network_changed="$(ip link show up)"
    if [ "$network_changed" = "$current_network" ] && [ "$connection_status" = "$(connected)" ]; then
	sleep 2; continue
    fi

    status=""
    # If a VPN connection is established, a tunnel is created.
    if [ -n "$(ip tuntap)" ]; then

	status=""
    fi

    response=$(curl -s -H "Accept: application/json" ipinfo.io/json)
    if [ -n "$response" ] && ! echo $response | jq -r '.ip' | grep -iq null; then

	ip=$(echo $response | jq -r '.ip')
	country=$(echo $response | jq -r '.country')
    else

	if ! throttled; then

	    default_interface=$(ip route | awk '/^default/ { print $5 ; exit }')
	    ip=$(ip addr show $default_interface | awk '/scope global/ {print $2; exit}' | cut -d/ -f1)
	    country="local"

	    # If there is no default interface, Internet is down.
	    if [ -z "$default_interface" ]; then
		status=""
		ip="127.0.0.1"
	    fi
	fi
    fi

    echo "$status $ip [$country]"
    current_network="$(ip link show up)"
    connection_status=$(connected)

done
