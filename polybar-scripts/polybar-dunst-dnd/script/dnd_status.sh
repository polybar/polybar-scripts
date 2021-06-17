#!/bin/bash
if [ $(dunstctl is-paused) = 'true' ]; then
	echo "%{F#707880}   "
else
	echo "   "
fi
