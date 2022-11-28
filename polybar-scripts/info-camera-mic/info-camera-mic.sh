#!/bin/sh

if lsof /dev/video0 >/dev/null 2>&1; then
    camera="#1"
fi

if pacmd list-sources 2>&1 | grep -q RUNNING; then
    mic="#2"
fi

echo "$camera $mic"
