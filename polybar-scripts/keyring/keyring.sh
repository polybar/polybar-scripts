#!/bin/bash

source "$(dirname $0)/polybar-keyring.conf"
#echo $path $icon_locked $icon_unlocked

Rscript $path/keyring_state.r

state=$(cat $path/state.tmp)
if [ "$state" = "locked" ]; then
    echo "${icon_locked}"
elif [ "$state" = "unlocked" ]; then
    echo "${icon_unlocked}"
else
    echo $state keyring polybar-keyring ERROR
fi
