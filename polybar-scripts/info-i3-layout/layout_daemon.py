#!/usr/bin/env python3

import fcntl
import os
import sys
import subprocess
import tempfile

from i3ipc import Connection, Event


previous = None


def update_indicator(i3, _):
    global previous
    tree = i3.get_tree()
    focused = tree.find_focused()
    if focused.type == "workspace":
        # empty workspace
        layout = focused.layout
    else:
        layout = focused.parent.layout

    if layout == previous:
        return
    previous = layout

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

    p = subprocess.Popen(["polybar-msg", "hook", "layout", hook])
    p.communicate()


def main():
    lockfile = os.path.normpath(tempfile.gettempdir() + '/i3_layout_daemon.lock')
    fp = open(lockfile, 'w')
    try:
        fcntl.lockf(fp, fcntl.LOCK_EX | fcntl.LOCK_NB)
    except IOError:
        print("Layout daemon already running")
        print("To kill, run 'pkill -f \"python.*layout_daemon.py\"'")
        exit(1)

    i3 = Connection()
    i3.on(Event.TICK, update_indicator)
    i3.on(Event.WINDOW_FOCUS, update_indicator)
    i3.on(Event.BINDING, update_indicator)
    update_indicator(i3, None)
    i3.main()


if __name__ == "__main__":
    main()

