#!/bin/sh

if [ "$(mocp -Q %state)" != "STOP" ];then
    echo "$(mocp -Q %song) - $(mocp -Q %album)"
else
    echo ""
fi
