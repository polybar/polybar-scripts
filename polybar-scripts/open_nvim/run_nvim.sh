#!/bin/sh

RECENT_FILE="$HOME/.recent_folders"
TERMINAL="your_terminal"

# get list recent folder and just folder
recent_dirs=$(cat "$RECENT_FILE" 2>/dev/null)
home_dirs=$(find "$HOME" -maxdepth 1 -type d -not -path '*/\.*' | head -10)

# remove duplicate
all_dirs=$(echo -e "$recent_dirs\n$home_dirs" | sort -u)

selected_dir=$(echo "$all_dirs" | rofi -no-config -no-lazy-grab -show drun -modi drun -theme ~/path_to_your_config -dmenu -p "📁 open in nvim:" -i)

if [ -n "$selected_dir" ] && [ -d "$selected_dir" ]; then
    echo "$selected_dir" > temp_recent
    cat "$RECENT_FILE" 2>/dev/null | grep -v "$selected_dir" | head -9 >> temp_recent
    mv temp_recent "$RECENT_FILE"
    
    # open nvim
    cd $selected_dir
    exec "$TERMINAL" -e nvim "$FULL_PATH"
fi
