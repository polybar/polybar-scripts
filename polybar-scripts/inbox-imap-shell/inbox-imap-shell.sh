#!/bin/sh

SERVER=""
USER=""
PASS=""

inbox=$(curl -sf -u "$USER":"$PASS" -X "STATUS INBOX (UNSEEN)" imaps://"$SERVER"/INBOX | tr -d -c "[:digit:]")

if [ "$inbox" ] && [ "$inbox" -gt 0 ]; then
    echo "# $inbox"
else
    echo ""
fi
