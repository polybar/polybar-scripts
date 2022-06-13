#!/bin/sh

TOKEN="$(echo MYTOKEN | base64)"
curl -s --header "Authorization: Basic ${TOKEN}"  https://wakatime.com/api/v1/users/current/status_bar/today  | jq -r '.data.grand_total.text';
