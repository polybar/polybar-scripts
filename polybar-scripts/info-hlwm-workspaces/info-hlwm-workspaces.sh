#!/usr/bin/env bash

# Multi monitor support. Needs MONITOR environment variable to be set for each instance of polybar
# If MONITOR environment variable is not set this will default to monitor 0
# Check https://github.com/polybar/polybar/issues/763
MON_IDX="0"
mapfile -t MONITOR_LIST < <(polybar --list-monitors | cut -d":" -f1)
for (( i=0; i<$((${#MONITOR_LIST[@]})); i++ )); do
  [[ ${MONITOR_LIST[${i}]} == "$MONITOR" ]] && MON_IDX="$i"
done;

herbstclient --idle "tag_*" 2>/dev/null | {

    while true; do
        # Read tags into $tags as array
        IFS=$'\t' read -ra tags <<< "$(herbstclient tag_status "${MON_IDX}")"
        {
            for i in "${tags[@]}" ; do
                # Read the prefix from each tag and render them according to that prefix
                case ${i:0:1} in
                    '#')
                        # the tag is viewed on the bar's monitor and is focused
                        # TODO Add your formatting tags for focused workspaces
                        ;;
                    '+')
                        # the tag is viewed on the bar's monitor, but is not focused
                        # TODO Add your formatting tags for viewed but unfocused tags
                        ;;
                    '!')
                        # ! the tag contains an urgent window
                        # TODO Add your formatting tags for workspaces with the urgent hint
                        ;;
                    '.')
                        # the tag is empty
                        # TODO Add your formatting tags for visible but not focused workspaces
                        ;;
                    *)
                        # default including not empty tags and tags viewed on another monitor (: - %)
                        # TODO Add your formatting tags for tags that or not currently viewed
                        # or displayed on another monitor
                        ;;
                esac

                # focus the monitor of the current bar before switching tags
                echo "%{A1:herbstclient focus_monitor ${MON_IDX}; herbstclient use ${i:1}:}  ${i:1}  %{A -u -o F- B-}"
            done

            # reset foreground and background color to default
            echo "%{F-}%{B-}"
        } | tr -d "\n"

    echo

    # wait for next event from herbstclient --idle
    read -r || break
done
} 2>/dev/null
