#!/bin/bash

streamer="$1" # You may change this to the streamer's username to override the command line argument.
filePath="~/polybar-scripts"
clientId=
#showSeconds=":%S" # Uncomment to show seconds in countdown - READ THE DOCS before uncommenting.

function checkLive() {
	while [[ $(curl -s https://api.twitch.tv/helix/streams?user_login="$streamer" -H "Client-ID: $clientId" | jq '.data[] | select(.type=="live")') ]]; do
		echo #1 "LIVE"
		sleep 10 # Waits 10 seconds between loop, to avoid constant cURLing
	done
}

function updateAuth() {
    chromium --remote-debugging-port=9222 --headless >/dev/null 2>&1 & disown # Starts chromium
    sleep .1 # Required wait
    chrome-har-capturer -f -c -g 7500 -o "$filePath/$streamer.har" https://twitch.tv/"$streamer" >/dev/null 2>&1 #& disown # Creates HAR file containing HTTP headers
    kill -1 "$(pgrep -f 'chromium --remote-debugging-port=9222 --headless')" # Kills headless chromium, since timeout function is disabled in debug mode
}

function checkReauth() {
	if [[ ! -f "$filePath/$streamer.har" || "$(($(date +%s)-$(date +%s -r "$filePath/$streamer.har")))" -gt 3300 ]]; then # Checks if auth from HAR is about to or has expired
		updateAuth
	fi
}

function updateData() {
	auth=$(jq -r '.["log"]["entries"][]["request"] | select(.url=="https://xt.streamlabs.com/api/v5/twitch-extensions/countdown/settings") | select(.method=="GET") | .["headers"][] | select(.name=="authorization") | .value' "$filePath/$streamer.har") # Gets authorization from HAR
	countdownData=$(curl -s https://xt.streamlabs.com/api/v5/twitch-extensions/countdown/settings -H "Authorization: $auth") # Curl settings from streamlabs API
	days=$(echo "$countdownData" | jq -r '.["enabled"] | keys[] as $k | "\($k), \(.[$k])" | select(endswith("true"))' | cut -d ',' -f1) # List all days streamer is streaming
    [[ -n "$1" ]] && days=$(echo "$days" | sed "/$1/d")
    
	closestDay="8days" # Further than any possible stream value
	for i in $days; do
	    dayUnixTime=$(date +%s --date="$i")
		if [[ "$dayUnixTime" -lt "$(date +%s --date=$closestDay)" ]]; then # Iterates through and determines the closest day that the streamer is streaming
			closestDay="$i"
	    fi
	done

	hour=$(echo "$countdownData" | jq -r ".[\"$closestDay\"][][\"HH\"]") # Get hour and minute of stream on closest day
	minute=$(echo "$countdownData" | jq -r ".[\"$closestDay\"][][\"mm\"]")
	timeZone=$(echo "$countdownData" | jq '.["timezone"]') # Get timezone
	streamTime=$(date +%s --date="TZ=$timeZone $closestDay $hour:$minute") # Get Unix time of the stream time, also factoring in timezone
	[[ "$(date +%s)" -gt "$streamTime" ]] && updateData "$closestDay" # Admittedly messy patch to ignore if past today's scheduled stream
}

function main() {
	while [[ "$streamTime" -ge "$(date +%s)" ]]; do
	    daysUntil="$(((streamTime - $(date +%s))/86400)):" # Determine how many days until the stream
	    [[ "$daysUntil" == "0:" ]] && daysUntil= # Removes days display if no days left
	    countdown="$(date -u --date @$((streamTime - "$(date +%s)")) +$daysUntil%H:%M"$showSeconds")"
	    echo #2 "$countdown"
	    [ $(($(date +%s) % 10)) -eq 0 ] && checkLive # Checks if user is live every 10 seconds, to avoid constant cURLing
		checkReauth
		sleep 1
	done
	checkLive
	updateAuth
	updateData
	main
}

checkLive
checkReauth
updateData
main
