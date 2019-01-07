#!/usr/bin/env bash

# early abort if there is no server running
# !!! this requires double brackets or success will return an error
! [[ $(tmux ls 2>/dev/null) ]] && printf 'tmux: none' && exit 0

# DLM stores the delimiter for the session names
# change this var for a custom seperator
readonly DLM=' | '

# make sure sessions is empty
[[ -n $sessions ]] && unset sessions

while read -r -a line; do    # pull the name from head of each line
  sesh="${line[0]}"          # tmp var
  # pop the ':' off or add attached to the session name 
  [[ ${line[-1]} != '(attached)' ]] && sessions+=( "${sesh//:/}" ) \
    || sessions+=( "${sesh}<attached>" ) 
done <<< "$(tmux ls)"

printf 'tmux: '

set -- "${sessions[@]}" # set new positional params

printf "%s" "$1"
shift
printf "%s" "${@/#/$DLM}"
