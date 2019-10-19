# Script: player-mpv-tail

A python script that shows current music track or movie title from `mpv`.

![player-mpv-tail](screenshots/1.png)


## Configuration

Set the `input-ipc-server` setting in your `~/.config/mpv/mpv.conf`:
```
input-ipc-server=/tmp/mpvsocket
```

Or run `mpv` with `--input-ipc-server=/tmp/mpvsocket` option.


## Module

```ini
[module/player-mpv-tail]
type = custom/script
exec = ~/.config/polybar/player-mpv-tail.py -t 42 -c '#abb2bf'
tail = true
click-left = ~/polybar-scripts/player-mpv-tail.py -p pause
click-middle = ~/polybar-scripts/player-mpv-tail.py -p playlist-pos -1
click-right = ~/polybar-scripts/player-mpv-tail.py -p playlist-pos +1
scroll-up = ~/polybar-scripts/player-mpv-tail.py -p time-pos -10
scroll-down = ~/polybar-scripts/player-mpv-tail.py -p time-pos +10
```
