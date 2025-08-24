#! usr/bin/env python

import argparse
import json

argparser = argparse.ArgumentParser(description = 'Display `bspwm` node flags')
argparser.add_argument(
    'node_tree',
    type = str,
    help = 'JSON output of `bspc query -T -n focused`',
    default = ''
)
args = argparser.parse_args()

# Parse node_tree JSON output.
node_tree = json.loads(args.node_tree)

# We're only concerned with displaying these flags.
flag_states = {
    'S': node_tree['sticky'],
    'X': node_tree['locked'],
    'M': node_tree['marked'],
    'P': node_tree['private']
}

# Filter out false flags.
if list(flag_states.values()).count(True) > 0:
    flags = [ ' ' ]
    for flag, state in flag_states.items():
        if state:
            flags.append(flag)

    print(''.join(flags))
else:
    # When we've got nothing, we want to clear the output.
    print('')
