#!/bin/sh
# shellcheck disable=SC2034

status=$(cmus-remote -Q | grep status | awk -F\  '{print $2}')
title=$(cmus-remote -Q | grep title | awk -F\  '{$1=$2=""; print $0}' | sed 's|^[[:blank:]]*||g')
artist=$(cmus-remote -Q | grep '[[:space:]]artist' | awk -F\  '{$1=$2=""; print $0}' | sed 's|^[[:blank:]]*||g')
position=$(cmus-remote -Q | grep position | awk -F\  '{print $2}') 
duration=$(cmus-remote -Q | grep duration | awk -F\  '{print $2}')

pos_minutes=$(("$position" / 60))
pos_minutes=$(printf "%02d" "$pos_minutes") 
pos_seconds=$(("$position" % 60))
pos_seconds=$(printf "%02d" "$pos_seconds") 

dur_minutes=$(("$duration" / 60))
dur_minutes=$(printf "%02d" "$dur_minutes") 
dur_seconds=$(("$duration" % 60))
dur_seconds=$(printf "%02d" "$dur_seconds") 

if test "$status" = 'stopped';
then
	echo "$status"
elif test "$status" = 'playing' || "$status" = 'paused'; 
then
	echo "$status" \| "$artist" - "$title" \| "$pos_minutes":"$pos_seconds" / "$dur_minutes":"$dur_seconds"
fi
