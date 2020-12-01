#!/bin/bash

DIRS=(
    "$HOME"/.dotfiles
    "$HOME"/.wallpapers
)

NAMES=(
    "dotfiles"
    "wallpapers"
)

diff_actives=false
diff_message="Commit: "

for i in "${!DIRS[@]}"
do
    dir="${DIRS[$i]}"
    name="${NAMES[$i]}"

    cd "$dir" || exit

    if [ "$(git status | grep -c "nothing to commit")" -eq 0 ]; then
        if "$diff_actives" ;then
            diff_message="$diff_message, $name"
        else
            diff_message="$diff_message $name"
        fi
        diff_actives=true
    fi
done

if "$diff_actives" ;then
    echo "$diff_message"
else
    echo ''
fi
