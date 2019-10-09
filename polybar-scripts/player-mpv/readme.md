# Script: player-mpv

A python script that shows current music track or movie from [mpv player](https://mpv.io/).

![preview](preview.png)

## Dependencies

bash, python, jq

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
exec = ~/.config/polybar/player-mpv/player-mpv.py -t 42 -c '#abb2bf'
label-font = 2
tail = true
click-left = ~/.config/polybar/player-mpv/mpv-control.sh -pause
click-middle = ~/.config/polybar/player-mpv/mpv-control.sh -prev
click-right = ~/.config/polybar/player-mpv/mpv-control.sh -next
scroll-up = ~/.config/polybar/player-mpv/mpv-control.sh -time -10
scroll-down = ~/.config/polybar/player-mpv/mpv-control.sh -time +10
```
