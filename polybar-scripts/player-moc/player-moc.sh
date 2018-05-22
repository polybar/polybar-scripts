#!/bin/sh

# Change according to information you wish to show in your polybar:
#        %state     State
#        %file       File
#        %title     Title
#        %artist    Artist
#        %song      SongTitle
#        %album     Album
#        %tt        TotalTime
#        %tl        TimeLeft
#        %ts        TotalSec
#        %ct        CurrentTime
#        %cs        CurrentSec
#        %b         Bitrate
#        %r         Rate

if [ "$(mocp -Q %state)" != "STOP" ]
then
    echo "$(mocp -Q %song) - $(mocp -Q %album)"
else 
    echo ""    
fi
