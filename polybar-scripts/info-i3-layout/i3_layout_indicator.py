#!/usr/bin/env python3
"""Script to update Polybar i3 layout indicator module. Run this on startup,
and add the module to the Polybar config file as shown in README.md."""

import fcntl
import os
import subprocess
import sys
from tempfile import gettempdir

from i3ipc import Connection, Event


PREVIOUS = None


def update_indicator(i3, _):
    """ Check if the layout has changed, and if so update the Polybar module

    This function is called whenever a relevant i3 event is triggered. The
    second argument contains the event data, which we don't care about.
    """
    global PREVIOUS
    tree = i3.get_tree()
    focused = tree.find_focused()
    if focused.type == "workspace":
        # Focus is on an empty workspace, so use layout of workspace
        layout = focused.layout
    else:
        # Focus is on a window, so use layout of parent element
        layout = focused.parent.layout

    # Only update indicator if the layout has changed
    if layout == PREVIOUS:
        return
    PREVIOUS = layout

    # Hook definitions
    if layout == "splith":
        hook = "1"
    elif layout == "splitv":
        hook = "2"
    elif layout == "tabbed":
        hook = "3"
    elif layout == "stacked":
        hook = "4"
    else:
        hook = "5"  # Fallback for unknown cases

    # Send Polybar message
    subprocess.run(["polybar-msg", "hook", "layout", hook])


def main():
    """If indicator script is not already running, subscribe to events"""
    # Get a lock on a temporary file to prevent multiple instances from
    # running, which would cause nasty race conditions
    lockfile = os.path.normpath(gettempdir() + "/i3_layout_indicator.lock")
    fp = open(lockfile, 'w')
    try:
        fcntl.lockf(fp, fcntl.LOCK_EX | fcntl.LOCK_NB)
    except IOError:
        print("i3 layout indicator is already running")
        print("To kill, run 'pkill -f \"python.*i3_layout_indicator.py\"'")
        sys.exit(1)

    # Bind events
    i3 = Connection()
    i3.on(Event.TICK, update_indicator)
    i3.on(Event.WINDOW_FOCUS, update_indicator)
    i3.on(Event.BINDING, update_indicator)

    # Update indicator once on startup
    update_indicator(i3, None)

    # Start listening for events
    i3.main()


if __name__ == "__main__":
    main()
