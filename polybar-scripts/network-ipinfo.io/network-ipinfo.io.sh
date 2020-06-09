#!/bin/sh

ipinfo=$(curl -sf "https://ipinfo.io/json")

if [ -n "$ipinfo" ]; then
    ipinfo_ip=$(echo "$ipinfo" | jq -r '.ip')
    ipinfo_country=$(echo "$ipinfo" | jq -r '.country')

    echo "# $ipinfo_ip [ $ipinfo_country ]"
else
    echo ""
fi
