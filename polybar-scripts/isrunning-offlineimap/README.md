# Script: isrunning-offlineimap

Offlineimap functionality.
The scripts require you to have setup offlineimap yourself.
They are not meant to use systemd, but you can easily modify,
they aren't more than 5 lines of code.

* toggleimap: Toggles offlineimap as a daemon on or off.
* checkimap: Prints to polybar status.

Wrote the script, because I don't want to be synching my mail all the time, but
want to easily toggle it with a click.

## Dependencies & Tips

Needs offlineimap and pgrep.

If you want colors, I suggest you define them in your environment.
That way you can control polybar colors (import them with `{env:XXX})` and you
can change the same colors by using the variables in your script.

You can obviously dump the scripts in your *PATH* and not worry about absolute paths. 

## Module

```ini
module/offlineimap]
type = custom/script
exec = ~/.config/polybar-scripts/isrunning-offlineimap/checkimap
interval = 5
format = <label>
label = %output%
click-left = ~/.config/polybar/isrunning-offlineimap/toggleimap
```
