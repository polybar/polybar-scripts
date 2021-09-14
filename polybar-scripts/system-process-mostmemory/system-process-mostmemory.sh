#!/bin/sh
proc=`ps --sort=+rss a o 'rss comm' | tail -1`
size=`echo $proc | sed 's/ .*//'`

if [ $(( $size>$1 )) == 1 ]; then
	echo -n $(( $size>>10 ))"MB " 
	echo $proc | sed "s/\S* //"
else
	echo
fi
