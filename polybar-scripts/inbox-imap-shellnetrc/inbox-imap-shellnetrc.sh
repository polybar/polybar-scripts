#!/bin/sh

SERVER=""
NETRC=".netrc"

inbox=$(curl -sf --netrc-file "$NETRC" -X "STATUS INBOX (UNSEEN)" imaps://"$SERVER"/INBOX | cut -d " " -f 5 | tr -d ")")

if [ $? = 0 ] && [ "$inbox" != 0 ]; then
    echo "# $inbox"
else
    echo ""
fi
