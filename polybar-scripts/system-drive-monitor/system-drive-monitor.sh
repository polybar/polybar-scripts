#!/usr/bin/env bash

df -H / | grep -vE '^Filesystem|tmpfs|cdrom' | awk '{ print $5 }'
