#!/bin/sh

a=$(/./opt/lampp/xampp status | grep Apa | cut -d " " -f3)
m=$(/./opt/lampp/xampp status | grep My | cut -d " " -f3)
f=$(/./opt/lampp/xampp status | grep Pro | cut -d " " -f3)
ret="";


if [ "$a" != "not" ]; then
	ret="A: %{F#0fe108}X%{F-}"
fi
if [ "$m" != "not" ]; then
	ret="$ret  M: %{F#0fe108}X%{F-}"
fi
if [ "$f" != "deactivated." ]; then
	ret="$ret  F: %{F#0fe108}X%{F-}"
fi
echo "$ret"