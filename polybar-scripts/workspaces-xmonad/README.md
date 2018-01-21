# Script: workspaces-xmonad

This plugin contains two modules, one for displaying workspaces and one for displaying title of current window.

The communication between XMonad and polybar is done by named pipes to achieve speed and memory efficiency.

You may adjust `eventLogHook` according to your preferences.


## Module

```ini
[module/workspaces-xmonad]
type = custom/script
exec = tail -F /tmp/.xmonad-workspace-log
exec-if = [ -p /tmp/.xmonad-workspace-log ]
tail = true
```

```ini
[module/title-xmonad]
type = custom/script
exec = tail -F /tmp/.xmonad-title-log
exec-if = [ -p /tmp/.xmonad-title-log ]
tail = true
```
