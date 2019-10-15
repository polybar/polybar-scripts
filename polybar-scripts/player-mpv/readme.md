# Script: player-mpv

A python script that shows current music track or movie title from [mpv player](https://mpv.io/).

![preview](preview.png)

## Dependencies

python

## Configuration

### 1. *~/.config/mpv/mpv.conf*
```
input-ipc-server=/tmp/mpvsocket
```
or run mpv with `--input-ipc-server=/tmp/mpvsocket` option.

### 2. Use narrow font like 'Fira Sans Compressed'

It's recommended (but not required), especially for small size monitors.
There's [ttf-fira-sans](https://www.archlinux.org/packages/community/any/ttf-fira-sans/) package for [ArchLinux](https://www.archlinux.org/) users.

## Module

```ini
[bar/top]
font-1 = "Fira Sans Compressed:style=Regular:size=7;3"

[module/mpv]
type = custom/script
exec = ~/.config/polybar/player-mpv.py -t 42 -c '#abb2bf'
label-font = 2
tail = true
click-left = ~/.config/polybar/player-mpv.py -p pause
click-middle = ~/.config/polybar/player-mpv.py -p playlist-pos -1
click-right = ~/.config/polybar/player-mpv.py -p playlist-pos +1
scroll-up = ~/.config/polybar/player-mpv.py -p time-pos -10
scroll-down = ~/.config/polybar/player-mpv.py -p time-pos +10
```
