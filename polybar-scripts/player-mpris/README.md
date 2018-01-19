# Script: player-mpris

A small script that shows the current track.


## Dependencies

* [playerctl](https://github.com/acrisci/playerctl)


## Module

```
[module/player-mpris]
type = custom/script
exec = ~/polybar-scripts/player-mpris.sh
interval = 3
click-left = playerctl previous
click-right = playerctl next
click-middle = playerctl play-pause
```
