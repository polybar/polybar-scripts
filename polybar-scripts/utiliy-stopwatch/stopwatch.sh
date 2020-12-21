#!/bin/bash

pid=$$


startTimer () {
	sec=0
	startdate=$(date +%s)
	while true
	do 
		let "sec = $(date +%s) - $startdate + 1"

		if [ "$sec" -lt 60 ]
			# fill time with raw seconds
			then time="$sec"
		# switch to minutes if more than 60 seconds
		else min=$(expr $sec / 60)
			# calculate the seconds minus the minutes
			relSec=$(expr $sec - $min \* 60)
			# fill time with minutes and relative seconds
			time="$min"'m'" $relSec"
		fi

		echo "$time" >> /tmp/polybar-stopwatch
		sleep 1
	done
}

initialize () {
	echo " " > /tmp/polybar-stopwatch 
}

initialize 

case $1 in
  new)
    echo $pid > /tmp/polybar-stopwatch-pid
    startTimer
    ;;
display)
    echo " " >> /tmp/polybar-stopwatch 
    ;;
tail)
    { tail -f /tmp/polybar-stopwatch 2>&1 >&3 3>&- | grep -v truncated >&2 3>&-;} 3>&1
    ;;
  cancel)
    kill "$(cat /tmp/polybar-stopwatch-pid)"
    ;;
  *)
    echo "Invalid Option"
    ;;
esac
