# Script: player-mpris-tail

This script displays the current track and the play-pause status without polling. Information is obtained by listening to MPRIS events, so it is updated instantaneously on change.

![player-mpris-tail](screenshots/1.png)

![player-mpris-tail](screenshots/2.png)


## Dependencies

* [playerctl](https://github.com/acrisci/playerctl)


## Module

```ini
[module/player-mpris-tail]
type = custom/script
exec = ~/polybar-scripts/player-mpris-tail.py
tail = true
click-left = playerctl previous
click-right = playerctl next
click-middle = playerctl play-pause
```
