#!/bin/sh

if info=$(cmus-remote -Q 2> /dev/null); then
	status=$(echo "$info" | grep status | awk -F\  '{print $2}')

	if [ "$status" = "playing" ] || [ "$status" = "paused" ]; then
		title=$(echo "$info" | grep title | awk -F\  '{$1=$2=""; print $0}' | sed 's|^[[:blank:]]*||g')
		artist=$(echo "$info" | grep '[[:space:]]artist' | awk -F\  '{$1=$2=""; print $0}' | sed 's|^[[:blank:]]*||g')
		position=$(echo "$info" | grep position | awk -F\  '{print $2}')
		duration=$(echo "$info" | grep duration | awk -F\  '{print $2}')

		pos_minutes=$(printf "%02d" $(("$position" / 60)))
		pos_seconds=$(printf "%02d" $(("$position" % 60)))

		dur_minutes=$(printf "%02d" $(("$duration" / 60)))
		dur_seconds=$(printf "%02d" $(("$duration" % 60)))

		if [ "$status" = "playing" ]; then
			echo "#1 $artist - $title | $pos_minutes:$pos_seconds / $dur_minutes:$dur_seconds"
		elif [ "$status" = "paused" ]; then
			echo "#2 $artist - $title | $pos_minutes:$pos_seconds / $dur_minutes:$dur_seconds"
		else
			echo ""
		fi
	else
		echo ""
	fi
else
	echo ""
fi
