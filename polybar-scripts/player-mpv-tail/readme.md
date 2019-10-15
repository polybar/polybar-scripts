# Script: player-mpv-tail

A python script that shows current music track or movie title from [mpv player](https://mpv.io/).

![preview](preview.png)

## Dependencies

python

## Configuration

*~/.config/mpv/mpv.conf*
```
input-ipc-server=/tmp/mpvsocket
```
or run mpv with `--input-ipc-server=/tmp/mpvsocket` option.

## Module

```ini
[module/mpv]
type = custom/script
exec = ~/.config/polybar/player-mpv-tail.py -t 42 -c '#abb2bf'
tail = true
click-left = ~/.config/polybar/player-mpv-tail.py -p pause
click-middle = ~/.config/polybar/player-mpv-tail.py -p playlist-pos -1
click-right = ~/.config/polybar/player-mpv-tail.py -p playlist-pos +1
scroll-up = ~/.config/polybar/player-mpv-tail.py -p time-pos -10
scroll-down = ~/.config/polybar/player-mpv-tail.py -p time-pos +10
```
