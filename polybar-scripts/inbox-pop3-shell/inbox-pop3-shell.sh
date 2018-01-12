#!/bin/sh

SERVER=""
USER=""
PASS=""

inbox=$(curl -sf -u "$USER":"$PASS" pop3s://"$SERVER" | wc -l)

if [ "$inbox" -gt 0 ]; then
    echo "# $inbox"
else
    echo ""
fi
