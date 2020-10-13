# Dunst Status & Toggle

This is a simple script that displays dunst's `is-paused` status.
It will display a different icon depending on the current status:

![](screenshots/1.png)
![](screenshots/2.png)

The script sets up a trap to support immediate status update on mouse click.
You can also create a script to bind to a key shortcut.
All you have to do to force update is to send `USR1` signal to the script's process.

## Dependencies

You will of course need to have dunst up and running, as well as
the new `dunstctl` tool available.

## Module Configuration

```
[module/dunst]
type = custom/script
format = <label>
label = %output%
exec = /path/to/dunst-status.sh
tail = true
click-left = dunstctl set-paused toggle && kill -USR1 %pid%
```

Make sure to set `tail = true`.
If you want to toggle notifications with a click, you need to run `dunstctl`
**and** send the signal to the process.
Alternatively, you can execute the toggle script shown below.

## Toggle Script

If you want to toggle status from terminal or by a key binding, you can
run the following script.
Notice that it uses `pgrep` to find the right process, and therefore
it assumes that only one such process is running.
If more than one process is found, it will use the top one.

```bash
#!/bin/sh
pid=$(pgrep dunst-status | head -1)
dunstctl set-paused toggle
kill -USR1 $pid
```

## Script Configuration

To configure the status icons or labels, simply modify
`ON` and `OFF` variables in the script.

Although the script will check the status every second,
this is not necessary if the status is always updated by
sending the `USR1` signal.
Thus, if you intend to only use the toggle script above
and/or click on the status, then you can safely increase
the one-second interval in the script, as running it too
often will unnecessarily waste resources.
