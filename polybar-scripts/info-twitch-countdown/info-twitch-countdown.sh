#!/bin/bash

streamer="$1" # You may change this to the streamer's username to override the command line argument.
filePath=""
clientId=
showSeconds=":%S" # Uncomment to hide seconds in countdown

function checkLive() {
	while [[ $(curl -s https://api.twitch.tv/helix/streams?user_login="$streamer" -H "Client-ID: $clientId" | jq '.data[] | select(.type=="live")') ]]; do
		echo "#1 LIVE"
		sleep 10
	done
}

function updateAuth() {
    chromium --remote-debugging-port=9222 --headless >/dev/null 2>&1 & disown
    sleep .1
    chrome-har-capturer -f -c -g 7500 -o "$filePath/$streamer.har" https://twitch.tv/"$streamer" >/dev/null 2>&1
    kill -1 "$(pgrep -f 'chromium --remote-debugging-port=9222 --headless')"
}

function checkReauth() {
	if [[ ! -f "$filePath/$streamer.har" || "$(($(date +%s)-$(date +%s -r "$filePath/$streamer.har")))" -gt 3300 ]]; then
		updateAuth
	fi
}

function updateData() {
	auth=$(jq -r '.["log"]["entries"][]["request"] | select(.url=="https://xt.streamlabs.com/api/v5/twitch-extensions/countdown/settings") | select(.method=="GET") | .["headers"][] | select(.name=="authorization") | .value' "$filePath/$streamer.har")
	countdownData=$(curl -s https://xt.streamlabs.com/api/v5/twitch-extensions/countdown/settings -H "Authorization: $auth")
	days=$(echo "$countdownData" | jq -r '.["enabled"] | keys[] as $k | "\($k), \(.[$k])" | select(endswith("true"))' | cut -d ',' -f1)
    [[ -n "$1" ]] && days=$(echo "$days" | sed "/$1/d")

	closestDay="8days"
	for i in $days; do
	    dayUnixTime=$(date +%s --date="$i")
		if [[ "$dayUnixTime" -lt "$(date +%s --date=$closestDay)" ]]; then
			closestDay="$i"
	    fi
	done

	hour=$(echo "$countdownData" | jq -r ".[\"$closestDay\"][][\"HH\"]")
	minute=$(echo "$countdownData" | jq -r ".[\"$closestDay\"][][\"mm\"]")
	timeZone=$(echo "$countdownData" | jq '.["timezone"]')
	streamTime=$(date +%s --date="TZ=$timeZone $closestDay $hour:$minute")
	[[ "$(date +%s)" -gt "$streamTime" ]] && updateData "$closestDay"
}

function main() {
	while [[ "$streamTime" -ge "$(date +%s)" ]]; do
	    daysUntil="$(((streamTime - $(date +%s))/86400)):"
	    [[ "$daysUntil" == "0:" ]] && daysUntil=
	    countdown="$(date -u --date @$((streamTime - "$(date +%s)")) +$daysUntil%H:%M"$showSeconds")"
	    echo "#2 $countdown"
	    [ $(($(date +%s) % 10)) -eq 0 ] && checkLive
		checkReauth
		sleep 1
	done
	checkLive
	updateAuth
	updateData
	main
}

checkLive
updateAuth
updateData
main
