#!/usr/bin/env python3

from i3ipc import Connection, Event
import subprocess
from tendo.singleton import SingleInstance, SingleInstanceException


previous = None


def update_indicator(i3, _):
    global previous
    tree = i3.get_tree()
    layout = tree.find_focused().parent.layout
    
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
    try:
        me = SingleInstance()
    except SingleInstanceException:
        print("Layout daemon already running")
        exit(1)

    i3 = Connection()
    i3.on(Event.TICK, update_indicator)
    i3.on(Event.WINDOW_FOCUS, update_indicator)
    i3.on(Event.BINDING, update_indicator)
    update_indicator(i3, None)
    i3.main()


if __name__ == "__main__":
    main()

