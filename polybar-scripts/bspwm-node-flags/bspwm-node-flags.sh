#! /usr/bin/env sh

bspc subscribe node | while read -a msg; do
    # A couple of the events that are output by `bspc subscribe node` are
    # `node_focus` and `node_stack` - we're only worried about the node being in
    # focus, or a flag being set on the current node.
    if [ "$msg[0]" = "node_focus" -o "$msg[1]" = "node_flag" ]
        # We're only concerned with displaying these flags.
        flag_states=$(bspc query -T -n focused \
            | jq -r '.sticky,.locked,.marked,.private')
        # Filter out false flags, and prepend a character to act as the name.
        flags=$(string match -ie true \
            'S:'$flag_states[1] 'X:'$flag_states[2] \
            'M:'$flag_states[3] 'P:'$flag_states[4])

        # If we've matched the string 'true' above, $flags will not be empty.
        if [ -z "$flags" ]
            output=' '
            for flag in $flags; do
                # The name is the first character before the ':'.
                set name (string split ':' $flag)[1]
                name=$(awk -F ':' '{ print $1 }' $flags)
                output="$output$name"
            done
            echo $output
        else
            # When we've got nothing, we want to clear the output.
            echo ''
        fi
    fi
done
