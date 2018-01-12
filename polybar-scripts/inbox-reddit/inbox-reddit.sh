#!/bin/sh

url="your url here"
unread=$(curl -sf "$url" | jq '.["data"]["children"] | length')

if [ "$unread" -gt 0 ]; then
   echo "#1 $unread"
else
   echo "#2"
fi
