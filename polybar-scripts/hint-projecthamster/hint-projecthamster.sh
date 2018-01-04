#!/bin/sh

activity=$(hamster current 2> /dev/null | cut -d' ' -f 3- | sed 's/@.* / - /')

if [ -n "$activity" ]; then
    echo "%{F#B48EAD} $activity"
else
    echo "%{F#65737E} No Activity"
fi
