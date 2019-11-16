# Script: player-mpris-simple

A small script that shows the current track.

![player-mpris-simple](screenshots/1.png)


## Dependencies

* [playerctl](https://github.com/acrisci/playerctl)


## Module

```ini
[module/player-mpris-simple]
type = custom/script
exec = ~/polybar-scripts/player-mpris-simple.sh
interval = 3
click-left = playerctl previous &
click-right = playerctl next &
click-middle = playerctl play-pause &
```
