#!/bin/sh

if cmus-remote -Q | grep 'playing'
then 
    cmus-remote -u;
else 
    cmus-remote -p;
fi
