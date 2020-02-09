#!/bin/sh

battery=$(sudo tlp-stat -b | tac | grep -m 1 "Charge" |  tr -d -c "[:digit:],.")

echo "# $battery %"
