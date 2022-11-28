#!/bin/bash

# Your API Key
API_KEY=""
# URL of the checks api endpoint. Change if self-hosting the service.
CHECK_ENDPOINT="https://healthchecks.io/api/v1/checks/"

# States to track
# Available options: up down new pending grace started paused
STATES=("up" "down")
# Color of each state. Defaults to white (#ffffff).
declare -A COLORS=( [up]="#7cfc00" [down]="#ff0000" )
# Leave empty to show all tags
SHOWN_TAGS=()

function build_url {
    url=$CHECK_ENDPOINT
    next_sep="?"
    for tag in "${SHOWN_TAGS[@]}"; do
        url+="${next_sep}tag=${tag}"
        next_sep="&"
    done
    echo "$url"
}

response=$(curl --silent --header "X-Api-Key: ${API_KEY}" "$(build_url)")

declare -A stati

for status in "up" "down"; do
    stati[$status]=0
done

for status in $(echo "$response" | jq -r '.checks[].status'); do
    stati[$status]=$((stati[$status] + 1))
done

output=""
for status in "${STATES[@]}"; do
    count=${stati[$status]}
    if [ ${COLORS[$status]+_} ]; then
        color=${COLORS[$status]}
    else
        color="#ffffff"
    fi
    output+="|%{F${color}}${count}%{F-}"
done

echo ${output:1}
