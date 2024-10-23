#! /usr/bin/env sh

bspc subscribe node | while read -a msg; do
    # A couple of the events that are output by `bspc subscribe node` are
    # `node_focus` and `node_stack` - we're only worried about the node being in
    # focus, or a flag being set on the current node.
    if [[ "$msg" == 'node_focus' || "$msg" == 'node_flag' ]]; then
        node_tree=$(bspc query -T -n focused)
        python $HOME/.config/polybar/scripts/bspwm-node-flags.py "$node_tree"
    fi
done
