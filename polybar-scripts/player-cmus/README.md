# Script: player-cmus

A small script that shows the current song. 

![player-cmus](screenshots/1.png) ![player-cmus-pause](screenshots/2.png)


## Module

```ini
[module/player-cmus]
type = custom/script
exec = ~/polybar-scripts/player-cmus.sh
exec-if = cmus-remote -Q
interval = 1
click-left = cmus-remote -n
click-right = cmus-remote -r
click-middle = ~/polybar-scripts/player-cmus-toggle.sh
```
