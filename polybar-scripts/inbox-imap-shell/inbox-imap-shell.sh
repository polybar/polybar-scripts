#!/bin/sh

SERVER=""
USER=""
PASS=""

inbox=$(curl -sf -u "$USER":"$PASS" -X "STATUS INBOX (UNSEEN)" imaps://"$SERVER"/INBOX | cut -d " " -f 5 | tr -d ")" | tr -d "\r")

if [ $? -eq 0 ] && [ "$inbox" -ne 0 ]; then
    echo "# $inbox"
else
    echo ""
fi
