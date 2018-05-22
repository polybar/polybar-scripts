# Script: player-moc

A small Script that shows the current song.

You can also control mocp.

*Note: You can change the maximum size of the text to be shown in the module by changing the value in "label-maxlen"

## Module

```ini
[module/player-moc]
type = custom/script
format = <label>
label-maxlen = 40
exec = ~/polybar-scripts/player-moc.sh
interval = 1
click-left = mocp -f
click-right = mocp -r
click-middle = mocp -P
```
