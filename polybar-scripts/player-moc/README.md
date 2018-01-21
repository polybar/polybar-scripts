# Script: player-moc

A small Script that shows the current song.

You can also control mocp.


## Module

```ini
[module/player-moc]
type = custom/script
exec = ~/polybar-scripts/player-moc.py
interval = 5
click-left = mocp -f
click-right = mocp -r
click-middle = mocp -P
```
