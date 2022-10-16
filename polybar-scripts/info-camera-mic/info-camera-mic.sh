#!/bin/sh
out=""

if lsof /dev/video0 >/dev/null 2>&1; then
    # Camera is active
    if [ -n "$out" ]; then
      out="$out "
    fi
    out="$out#1"
fi

if pacmd list-sources 2>&1 | grep -q RUNNING; then
    # Microphone is active
    if [ -n "$out" ]; then
      out="$out "
    fi
    out="$out#2"
fi

echo "$out"
