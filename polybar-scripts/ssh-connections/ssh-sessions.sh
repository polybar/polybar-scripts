#!/bin/bash

SSH_CONNECTIONS="$(lsof -Pi | grep '\:22')"
CONNECTION_COUNT=0

if [[ ! -z "$SSH_CONNECTIONS" ]]; then
  echo "not null"
  CONNECTION_COUNT="$(echo "$SSH_CONNECTIONS" | wc -l)"
fi

SSH_HOST="$(echo "$SSH_CONNECTIONS" | cut -d\> -f2 | cut -d\  -f1 | cut -d: -f1 | tail -n1)"
RESULT_STRING="ssh: ($CONNECTION_COUNT)"

if [[ -z "$SSH_HOST" ]]; then
  echo "$RESULT_STRING"
else
  echo "$RESULT_STRING: $SSH_HOST"
fi
