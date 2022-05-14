#!/bin/bash


# Folder for icons
CACHE=$$CACHE

# Path to your ixwindow folder
DIR=$$DIR


PREV_ICON="/tmp/polybar-icon-prev"

GAP="         "


# Delete previous icons, becase if there will be many
# overlaping icons it may cause a slow down of your window manager
cleanup_icons() {
    local icons_id=($(xdo id -n "polybar-xwindow-icon" 2> /dev/null))

    for icon in "${icons_id[@]}";
    do
        xdo kill "$icon" &> /dev/null 
    done
}


reset_prev_icon() {
    echo "" > "$PREV_ICON"
}



print_info() {
    echo -n "$GAP"

    if [ "$1" = "Empty" ]; then
        echo "Empty"
    else
        local wid="$1"
        
        # Doesn't always work, so xprop is more realiable here 
        # WM_CLASS="$(bspc query -T -n "$Node" | jq -r '.client.className')"  
        local WM_CLASS="$(xprop -id "$wid" WM_CLASS | awk '{print $4}' | tr -d '"')"
        

        case "$WM_CLASS" in
            'Brave-browser')
                echo "Brave";;
            'TelegramDesktop')
                echo "Telegram";;
            *)
                # https://stackoverflow.com/questions/1538676/uppercasing-first-letter-of-words-using-sed
                echo "$WM_CLASS" | sed -e "s/\b\(.\)/\u\1/g";;
        esac
    fi
}


exists_fullscreen_node() {
    local fullscreen_nodes="$(bspc query -N -n .fullscreen.\!hidden -d "$1")"

    if [ -n "$fullscreen_nodes" ]; then 
        echo '1'
    else
        echo '0'
    fi
}


display_icon() {
    cleanup_icons
    icon="$CACHE/$1.jpg"
    if [ -f "$icon" ]; then
        "$DIR/polybar-xwindow-icon" "$icon" &> /dev/null &
    fi
}


generate_icon() {
    "$DIR/generate-icon" "$CACHE" "$1"
}

update_prev_icon() {
   echo "$1" > "$PREV_ICON" 
}

process_window() {
    local desk="$2"    
    local wid="$1"
    local WM_CLASS="$(xprop -id "$wid" WM_CLASS | awk '{print $4}' | tr -d '"')"
    
    # If there is a fullscreen node, don't show anything, 
    # since we shouldn't see it
    if [ "$(exists_fullscreen_node "$desk")" = "1" ]; then
        cleanup_icons
        reset_prev_icon
        return 0;
    fi

    generate_icon "$wid"
   
    # We use icon-prev thing just so icon won't blink 
    # when one is switching between the same types of windows
    local WM_CLASS_PREV="$(cat "$PREV_ICON")"

    if [ "$WM_CLASS" = "$WM_CLASS_PREV" ]; then
        return 0;
    else
        update_prev_icon "$WM_CLASS"
    fi
   

    display_icon "$WM_CLASS"

    print_info "$wid"
}


is_desktop_empty() {
    local desk="$1"
    local nodes="$(bspc query -N -n .window.\!hidden  -d "$desk")"


    if [ -n "$nodes" ]; then 
        echo '0'
    else
        echo '1'
    fi
}

process_desktop() {
    local desk="$1"
    local is_empty="$(is_desktop_empty "$desk")"

    if [ "$is_empty" = "1" ]; then
        reset_prev_icon
        cleanup_icons 

        print_info "Empty"
    fi

}


reset_prev_icon


bspc subscribe node_focus | while read -r Event Monitor Desktop Node
do
    # For some reason "$Node" and "$Desktop" are not always working 
    # properly with sticky windows
    Node="$(xdotool getactivewindow)"
    Desktop="$(bspc query -D -d focused)"

    process_window "$Node" "$Desktop"

done &


bspc subscribe node_state | while read -r Event Monitor Desktop Node State Active 
do
    Node="$(xdotool getactivewindow)"
    Desktop="$(bspc query -D -d focused)"

    if [ "$State" != "fullscreen" ]; then
        continue;
    fi
    
    # So, if you will focus on the other windows of the same app,
    # which are not fullscreen, you will see icon

    reset_prev_icon

    if [ "$Active" = "on" ]; then
        cleanup_icons
    else
        process_window "$Node"  "$Desktop"
    fi

done &


bspc subscribe node_add | while read -r Event Monitor Desktop Ip Node 
do
    State="$(bspc query -T -n "$Node" | jq -r '.client.state')"

    if [ "$State" = "fullscreen" ]; then
        reset_prev_icon
        cleanup_icons
    fi

done &


bspc subscribe node_flag | while read -r Event Monitor Desktop Node Flag Active 
do
    if [ "$Flag" = "hidden" ] && [ "$Desktop" = "$(bspc query -D -d .focused)" ]; then
        process_desktop "$Desktop"
    fi

done &




bspc subscribe node_remove | while read -r Event Monitor Desktop Node 
do
    process_desktop "$Desktop"

done &


bspc subscribe desktop_focus | while read -r Event Monitor Desktop 
do

    if [ "$(exists_fullscreen_node "$Desktop")" = "1" ]; then
        reset_prev_icon
        cleanup_icons
        continue;
    fi

    process_desktop "$Desktop"

done 

