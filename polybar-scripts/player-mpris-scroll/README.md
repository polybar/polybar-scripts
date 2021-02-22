# Script: player-mpris-scroll

A small script that shows the current track.
It can limit the width and scroll the display.



## Dependencies

* [playerctl](https://github.com/acrisci/playerctl)


## Module

```ini
[module/player-mpris-simple]
type = custom/script
; Temporary files are saved in $HOME/temp
; parameter：icon position/max width/scrollable/scroll step
exec = ~/polybar-scripts/player-mpris-simple.sh left 20 true 1
interval = 1
click-left = playerctl previous &
click-right = playerctl next &
click-middle = playerctl play-pause &
```

## [Note]
Install![playerctl](https://github.com/altdesktop/playerctl),exec`playerctld daemon`.

