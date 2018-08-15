# Script: player-moc

A small script that shows the current song. You can also control mocp.


## Module

```ini
[module/player-moc]
type = custom/script
exec = ~/polybar-scripts/player-moc.sh
interval = 3
click-left = mocp -f
click-right = mocp -r
click-middle = mocp -G
```
