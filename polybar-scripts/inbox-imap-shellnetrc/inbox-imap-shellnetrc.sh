#!/bin/sh

SERVER=""
NETRC=".netrc"

inbox=$(curl -sf --netrc-file "$NETRC" -X "FETCH 1:* FLAGS" imaps://"$SERVER"/INBOX | grep -vic seen)

if [ "$inbox" -gt 0 ]; then
    echo "# $inbox"
else
    echo ""
fi
