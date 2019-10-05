#!/bin/sh

battery=$(sudo tlp-stat -b | grep "Charge total" |  tr -d -c "[:digit:],.")

echo "# $battery %"
