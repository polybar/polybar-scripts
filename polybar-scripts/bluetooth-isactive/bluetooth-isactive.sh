#!/bin/sh

status=$(systemctl is-active bluetooth.service)

if [ "$status" = "active" ]
then
	echo "#1"
else
	echo "#2"
fi
