# Music Player - Basic track info (MPRIS) - No Poll
![mpris playing](screenshots/playing.png)
![mpris paused](screenshots/paused.png)

This script displays the current track and the play-pause status without
polling. Information is obtained by listening to MPRIS events, so it is updated
instantaneously on change.

## Dependencies
* [aur: ttf-font-awesome](https://aur.archlinux.org/packages/ttf-font-awesome/)
* [playerctl](https://github.com/acrisci/playerctl)

## Module
```ini
[module/music]
type = custom/script
exec = ~/.config/polybar/mpris.py

tail = true
```
