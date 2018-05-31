#!/bin/sh

showIfEmpty=1
url="your url here"
unread=$(curl -sf "$url" | jq '.["data"]["children"] | length')

case "$unread" in
    ''|*[!0-9]*)
       unread=0
esac;

if [ "$unread" -gt 0 ]; then
   echo "#1 $unread"
else
   if [ "$showIfEmpty" -gt 0 ]; then
      echo "#1 0"
   else
      echo "#2"
   fi
fi
