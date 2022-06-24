#!/bin/sh

TOKEN=""

curl -s --header "Authorization: Basic $(echo "$TOKEN" | base64)" https://wakatime.com/api/v1/users/current/status_bar/today  | jq -r '.data.grand_total.text'
