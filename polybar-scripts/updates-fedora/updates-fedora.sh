#!/bin/sh

# Choose the dnf command this script use to retrieve updates information
#
# 1 - updateinfo 
#     Shows uninstalled updates but doesn't show new dependencies
# 2 - update (need sudo privilege)
#     Shows uninstalled updates and new dependencies

mode="$1"

case "$mode" in
  1)
    updates=$(dnf -q updateinfo --list --updates 2> /dev/null | wc -l )
    ;;
  2)
    dnf=$(env LC_ALL=C sudo dnf upgrade --assumeno 2> /dev/null)
    
    upgrade=$(echo "$dnf" | grep '^Upgrade ' | awk '{ print $2 }')
    install=$(echo "$dnf" | grep '^Install ' | awk '{ print $2 }')

    updates=$(( upgrade + install ))
    ;;
  *)
    updates=$(dnf -q updateinfo --list --updates 2> /dev/null | wc -l )
    ;;
esac

if [ "$updates" -gt 0 ]; then
  echo "$updates"
else
  echo ""
fi
