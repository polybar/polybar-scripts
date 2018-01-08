#!/bin/sh

SERVER=""
USER=""
PASS=""

inbox=$(curl -sf -u "$USER":"$PASS" -X "STATUS INBOX (UNSEEN)" imaps://"$SERVER"/INBOX | cut -d " " -f 5 | tr -d ")")

if [ $? = 0 ] && [ "$inbox" != 0 ]; then
    echo "# $inbox"
else
    echo ""
fi
