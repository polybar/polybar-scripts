#!/bin/sh

# Put the class name and its icon here
icon_map="
Google-chrome 
Brave-browser 
Firefox 
Code ﬏
Slack 
kitty 
Alacritty 
Nautilus 
"

# Put the names of windows you want to ignore here
ignore_list="
Scratchpad
Volume-mixer
"

# Presets
display_name="class" # valid: name/class
name_cut=15
empty_message="..."
underline_enabled="true"
# Use colors as in polybar config (e.g. "#efefef"),
# must be "-" if there is no color specified.
foreground_focused="-"
background_focused="-"
foreground_unfocused="#999"
background_unfocused="-"
underline_color="#8bbaed"


# Enable underline
[ "$underline_enabled" = "true" ] && underline="%{u$underline_color}%{+u}"

# Subscribe to events on which the window title will get updated
bspc subscribe node_focus node_remove node_stack desktop_focus | while read -r _; do
    # Get active monitor, all windows and the focused window
    monitor=$(bspc query -M -d focused --names)
    window_ids=$(bspc query -N -n .window -m .focused -d .active)
    window_focused_id=$(bspc query -N -n focused)

    for window_id in $window_ids; do
        window_name=$(xdotool getwindowname $window_id)

        if [ -z "$(echo "$ignore_list" | grep "$window_name")" ]; then
            window_class=$(xdotool getwindowclassname $window_id)

            # Cut the window name
            if [ "$display_name" = "name" ]; then
                window=$(echo "$window_name" | cut -c-"$name_cut")
            else
                window=$(echo "$window_class" | cut -c-"$name_cut")
            fi

            # Get icon for class name
            window_icon=$(echo "$icon_map" | grep "$window_class")

            # Assemble the bar, put focused window to the begining
            if [ "$window_id" = "$window_focused_id" ]; then
                curr_wins="%{F$foreground_focused B$background_focused}$underline %{A3:bspc node $window_id --close:}${window_icon#* } ${window} %{A}%{-u}%{F$foreground_unfocused B$background_unfocused}${curr_wins}"
            else
                curr_wins="${curr_wins} %{A1:bspc node $window_id --focus:}%{A3:bspc node $window_id --close:}${window_icon#* } ${window} %{A}%{A}"
            fi
        fi
    done

    # Print to temp file and trigger the polybar hook
    [ -z "$curr_wins" ] && curr_wins=$empty_message
    echo "$curr_wins" > "/tmp/bspwm_windows.${monitor}"
    polybar-msg hook titles-bspwm 1

    unset curr_wins
done
