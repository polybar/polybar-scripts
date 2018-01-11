#!/bin/sh

battery=$(sudo tlp-stat -b | tail -2 | head -n 1 | tr -d -c "[:digit:],.")

echo "# $battery %"
