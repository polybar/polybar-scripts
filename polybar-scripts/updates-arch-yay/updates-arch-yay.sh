#!/bin/sh

prepend="# "
yay_command="yay -Qu --quiet"

if [ "$1" == "arch" ]; then
  yay_command="$yay_command --repo"
  shift
elif [ "$1" == "aur" ]; then
  yay_command="$yay_command --aur"
  shift
fi

if [ -n "$1" ]; then
  prepend="$1 "
fi

updates="$($yay_command 2> /dev/null)"

# yay doesn't output network errors to STDERR
if echo "$updates" | grep -E 'failure in |error: failed' --quiet; then
  updates=0
else
  updates=$(test -n "$updates" && echo "$updates" | wc -l || echo 0)
fi

if [ "$updates" -gt 0 ]; then
    echo "${prepend}${updates}"
else
    echo ""
fi
