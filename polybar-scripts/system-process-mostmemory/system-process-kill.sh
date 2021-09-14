#!/bin/sh
proc=`ps --sort=+rss a o 'rss pid' | tail -1`
size=`echo $proc | sed 's/ .*//'`

echo proc: $proc


if [ $(( $size>$1 )) == 1 ]; then
	kill -9 `echo $proc | sed "s/\S* //"`
fi
