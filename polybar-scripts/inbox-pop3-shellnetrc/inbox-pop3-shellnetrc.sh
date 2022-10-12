#!/bin/sh

SERVER=""
NETRC=".netrc"

inbox=$(curl -sf --netrc-file "$NETRC" pop3s://"$SERVER" | wc -l)

if [ "$inbox" -gt 0 ]; then
    echo "# $inbox"
else
    echo ""
fi
