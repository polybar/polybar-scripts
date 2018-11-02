#!/bin/bash

status=$(cmus-remote -Q | grep status | awk -F\  '{print $2}')
title=$(cmus-remote -Q | grep title | awk -F\  '{$1=$2=""; print $0}')
artist=$(cmus-remote -Q | grep [[:space:]]artist | awk -F\  '{$1=$2=""; print $0}')
position=$(cmus-remote -Q | grep position | awk -F\  '{print $2}') 
duration=$(cmus-remote -Q | grep duration | awk -F\  '{print $2}')

let 'pos_minutes = position / 60'
pos_minutes=$(printf "%02d" $pos_minutes) 
let 'pos_seconds = position % 60'
pos_seconds=$(printf "%02d" $pos_seconds) 

let 'dur_minutes = duration / 60'
dur_minutes=$(printf "%02d" $dur_minutes) 
let 'dur_seconds = duration % 60'
dur_seconds=$(printf "%02d" $dur_seconds) 

if [ $status == 'stopped' ]
then
	echo $status
elif [ $status == 'playing' ] || [ $status == 'paused' ] 
then
	echo $status \| $artist - $title \| $pos_minutes:$pos_seconds \/ $dur_minutes:$dur_seconds
fi
