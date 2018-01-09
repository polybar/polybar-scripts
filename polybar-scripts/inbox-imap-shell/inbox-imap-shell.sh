#!/bin/sh

SERVER=""
USER=""
PASS=""

inbox=$(curl -sf -u "$USER":"$PASS" -X "FETCH 1:* FLAGS" imaps://"$SERVER"/INBOX | grep -vic seen)

if [ "$inbox" -gt 0 ]; then
    echo "# $inbox"
else
    echo ""
fi
