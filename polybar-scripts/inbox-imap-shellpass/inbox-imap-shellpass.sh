#!/bin/sh

SERVER=""
LOGIN=""
PASS=""
KEYGRIP=""

if [ "$(gpg-connect-agent 'keyinfo --list' /bye | grep "$KEYGRIP" | awk '{ print $7 }')" = 1 ]; then
    password=$(pass show "$PASS" | head -n 1)
    inbox=$(echo "user = \"$LOGIN:$password\"" | curl -sf -K- -X "STATUS INBOX (UNSEEN)" imaps://"$SERVER"/INBOX | tr -d -c "[:digit:]")

    if [ "$inbox" ] && [ "$inbox" -gt 0 ]; then
        echo "# $inbox"
    else
        echo ""
    fi
else
    echo ""
fi
