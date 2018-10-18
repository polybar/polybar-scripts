#!/bin/sh

if [ "$(mocp -Q %state)" != "STOP" ];then
    SONG=$(mocp -Q %song)
    
    if [ -z "$SONG" ]; then
        basename "$(mocp -Q %file)"
    else
        echo "$SONG - $(mocp -Q %album)"
    fi
else
    echo ""
fi
