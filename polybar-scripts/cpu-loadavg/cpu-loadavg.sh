#!/bin/sh

awk '{print $1" "$2" "$3}' < /proc/loadavg
