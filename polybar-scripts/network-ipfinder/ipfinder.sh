#!/bin/sh

# Sometimes, when there is no Internet connection, curl will continue to retry. If the total time is longer than MAX_TIME we want to abort. 
MAX_TIME=5 # seconds

response=$(curl -m "$MAX_TIME" -sf -H "Accept: application/json" ipinfo.io/json)
if [ -n "$response" ] && ! echo "$response" | jq -r '.ip' | grep -iq null; then

    ip=$(echo "$response" | jq -r '.ip')
    country=$(echo "$response" | jq -r '.country')
fi 

echo "$ip [$country]"

