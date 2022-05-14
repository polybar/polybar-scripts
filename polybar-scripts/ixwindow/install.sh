#!/bin/bash

# Destination folder
PREFIX="$HOME/.config/polybar/scripts/ixwindow"

# Size of the icon
SIZE=24

# Background color of your polybar
COLOR="#252737"

# Coordinates of icon, you might wanna play around with
# GAP option in the ixwindow file as well
X=270
Y=6

CACHE="$HOME/.config/polybar/scripts/ixwindow/polybar-icons"


cp -R ixwindow ixwindow_compiled

mkdir -p "$CACHE"
mkdir -p "$PREFIX"


sed -i "s/\$X/$X/g" ixwindow_compiled/polybar-xwindow-icon.cpp
sed -i "s/\$Y/$Y/g" ixwindow_compiled/polybar-xwindow-icon.cpp
sed -i "s/\$SIZE/$SIZE/g" ixwindow_compiled/polybar-xwindow-icon.cpp


sed -i "s/\$\$SIZE/$SIZE/g" ixwindow_compiled/generate-icon
sed -i "s/\$\$COLOR/\"$COLOR\"/g" ixwindow_compiled/generate-icon

CACHE="$(echo "$CACHE" | sed -e 's/\\/\\\\/g; s/\//\\\//g; s/&/\\\&/g')"
DIR="$(echo "$PREFIX" | sed -e 's/\\/\\\\/g; s/\//\\\//g; s/&/\\\&/g')"


sed -i "s/\$\$CACHE/\"$CACHE\"/g" ixwindow_compiled/ixwindow
sed -i "s/\$\$DIR/\"$DIR\"/g" ixwindow_compiled/ixwindow


g++ -o ixwindow_compiled/polybar-xwindow-icon ixwindow_compiled/polybar-xwindow-icon.cpp "$(pkg-config --cflags --libs opencv)" -lX11


mv ixwindow_compiled/* "$PREFIX"

rm -r ixwindow_compiled
