#!/usr/bin/env bash

time=$((20 - $(date '+%-M') % 20))

echo "$time"
