#!/bin/bash
#
# This script can toggle xfce4-power-manager presentation mode and show a
# message representing its current state to be displayed in polybar. It is
# intended to be used in polybar, but it does work from any bash shell.
#
# [module/presentation-mode]
# type = custom/script
# exec = ~/polybar-scripts/xfce4-presentation-mode.sh
# label = %output%
# click-left = ~/polybar-scripts/xfce4-presentation-mode.sh toggle

# Output when presentation mode is on
msg_on=
# Keeping the output empty when the mode is off hides the icon in polybar
msg_off=""

action=${1:-}
declare -A valid_actions=( [toggle]=toggle [enable]=enable [disable]=disable )

show_help() {
    local script_name=${0##*/}

    printf "%s\n" """
    Usage: ${script_name} [OPTIONS]

    Display xfce4-power-manager presentation mode state or toggle it

    Options:
        enable          enable presentation mode
        disable         disable presentation mode
        toggle          toggle presentation mode
        anything else   display this help""" | \
    sed -E 's/^\s{4}//g'
}

# The first arg passed to this script is invalid
[[ ${action} && ! ${valid_actions[$action]} ]] && show_help && exit 1

cmd=( "xfconf-query" "-c" "xfce4-power-manager"
    "-p" "/xfce4-power-manager/presentation-mode")

toggle_presentation_mode() {
    local set=${1:-}
    local enabled="true"

    if [[ ${set} == toggle ]]; then
        [[ $("${cmd[@]}") == "true" ]] && enabled="false"
    else
        [[ ${set} == enable ]] || enabled="false" 
    fi

    "${cmd[@]}" -s "${enabled}"
}

[[ ${action} ]] && toggle_presentation_mode "${action}"

[[ $("${cmd[@]}") == "true" ]] && echo "${msg_on}" || echo "${msg_off}"

exit 0

# vim: fdm=manual tabstop=4 softtabstop=4 shiftwidth=4 expandtab:
