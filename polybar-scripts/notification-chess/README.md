# Script: notification-chess

A small script that indicates whether you need to move.


## Dependencies

* `curl`
* `jq`
* obviously a chess.com account


## Module

```
[module/notification-chess]
type = custom/script
exec = ~/polybar-scripts/notification-chess.sh
interval = 10
click-left = xdg-open https://www.chess.com/goto_ready_game & disown
```
