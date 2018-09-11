# Script: player-mpris-tail

This script displays the current track and the play-pause status without polling. Information is obtained by listening to MPRIS events, so it is updated instantaneously on change.

![player-mpris-tail](screenshots/1.png)
![player-mpris-tail](screenshots/2.png)


## Dependencies

* [playerctl](https://github.com/acrisci/playerctl)


## Module

Default output format
```ini
[module/player-mpris-tail]
type = custom/script
exec = ~/polybar-scripts/player-mpris-tail.py
tail = true
click-left = ~/polybar-scripts/player-ctrl.sh previous
click-right = ~/polybar-scripts/player-ctrl.sh next
click-middle = ~/polybar-scripts/player-ctrl.sh play-pause
```

Custom output format
```ini
[module/player-mpris-tail]
type = custom/script
exec = ~/polybar-scripts/player-mpris-tail.py '{icon} {title}'
tail = true
click-left = ~/polybar-scripts/player-ctrl.sh previous
click-right = ~/polybar-scripts/player-ctrl.sh next
click-middle = ~/polybar-scripts/player-ctrl.sh play-pause
```
The format string supports the following tags:

* `{icon}`: playing status icon
* `{artist}`: artist name
* `{title}`: song title
