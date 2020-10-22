# Script: i3 layout indicator

A basic indicator that shows the layout for the currently focused i3 window, useful for determining where the next tiled window will be placed. The indicator is updated any time the layout is changed with a key binding and any time a new window gains focus.

![vertical-indicator](screenshots/1.png)


## Dependencies

* i3wm
* Python 3.6+
* i3ipc Python package (`pip3 install i3ipc`)


## Configuration

Execute the `layout_daemon.py` script on startup, e.g. by adding `exec --no-startup-id path/to/layout_daemon.py` to `.config/i3/config`. (Remember to mark the script as executable first.) The script runs as a singleton, so to restart it you will first need to kill the running instance, e.g. by running `pkill -f "python.*layout_daemon.py"`.


## Module

The callback hooks used are:
* hook-0: Horizontal split layout
* hook-1: Vertical split layout
* hook-2: Tabbed layout
* hook-3: Stacked layout
* hook-4: Fallback used for any other layout string (this shouldn't happen unless later versions of i3 add new layouts)

In addition to `window::focus` and `binding` events, the script subscribes to `tick` events, so that it can be updated manually by calling `i3-msg -t SEND_TICK`. Add this if you want to change the layout with a click event, as in the example configuration below.

```ini
[module/layout]
type = custom/ipc
hook-0 = echo "H"
hook-1 = echo "V"
hook-2 = echo "T"
hook-3 = echo "S"
hook-4 = echo "?"
initial = 1
click-left = i3-msg layout toggle split; i3-msg -t SEND_TICK
click-right = i3-msg layout tabbed; i3-msg -t SEND_TICK
```

