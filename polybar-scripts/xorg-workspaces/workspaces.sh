#!/bin/bash

CURRENT="+"
BACKGROUND="-"

cur=`xprop -root _NET_CURRENT_DESKTOP | awk '{print $3}'`
tot=`xprop -root _NET_NUMBER_OF_DESKTOPS | awk '{print $3}'`
cur=$(($cur + 1)) 

for ((i = 1; i <= $tot; i++)); do
	if [ "$i" = "$cur" ]
	then
		echo -n "$CURRENT "
	else
		echo -n "$BACKGROUND "
	fi
done
