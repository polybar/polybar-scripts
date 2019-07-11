#!/bin/sh

list=$(xbps-install -nuM | awk '{print $1}' | head -6 )

if ! updates=$(xbps-install -nuM | wc -l); then
	updates=0
fi

if [ "$updates" -gt 0 ]; then
	notify-send -i "~/polybar-scripts/updates.png" "Hay $updates actualizaciones disponibles:" "$list \n ..."
	echo "$updates"
else
	echo ""
fi
