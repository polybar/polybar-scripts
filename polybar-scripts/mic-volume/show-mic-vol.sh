#!/bin/sh

vol=$(amixer sget Capture | grep "Front Left" | sed -n 2p | awk '{ print $5 }')
echo "Mic Vol 🎙️: $vol"
