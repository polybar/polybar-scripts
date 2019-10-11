#!/bin/bash

if [ "$(bluetoothctl show | awk '/Powered/ { print $2 }' )" == "no" ]
then
	echo ""
	exit
else
	devices=($(bluetoothctl paired-devices | awk '{print $2}'))
	for i in ${devices[@]}
	do
		if [ "$(bluetoothctl info ${i} | awk '/Connected/ {print $2}')" == "yes" ]
		then
			echo ""
			exit
		fi
	done
	echo ""
fi
