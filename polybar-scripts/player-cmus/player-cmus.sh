#!/bin/sh

if cmus-remote -Q | grep -q 'paused'
then 
    echo "paused"; 
else 
    cmus-remote -Q | grep 'file' | awk -F/ '{print $NF}'; 
fi
