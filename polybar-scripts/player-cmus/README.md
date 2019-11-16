# Script: player-cmus

A script that displays information about the current track (artist, title, position, duration).

![player-cmus](screenshots/1.png)


## Module

```ini
[module/player-cmus]
type = custom/script
exec = ~/polybar-scripts/player-cmus.sh
interval = 5
click-left = cmus-remote -n &
click-right = cmus-remote -r &
click-middle = cmus-remote -u &
```
