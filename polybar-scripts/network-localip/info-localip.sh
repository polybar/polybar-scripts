#!/bin/sh

local_interface=$(route | awk '/^default/{print $NF}')
local_ip=$(ip addr show "$local_interface" | grep -w "inet" | awk '{ print $2; }' | sed 's/\/.*$//')

echo "# $local_ip"
