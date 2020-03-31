#!/bin/sh

active_interface=$(route | awk '/^default/{print $NF}')
ip addr show "$active_interface" | grep -w "inet" | awk '{ print $2; }' | sed 's/\/.*$//'
