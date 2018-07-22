# Script: popup-calendar

A small script that displays the date and opens a small popup calendar with YAD when clicked.

![popup-calendar](screenshots/1.png)


## Dependencies

* [`yad`](https://sourceforge.net/projects/yad-dialog/)
* `xdotool`


## Configuration

Change these values if you want:

```sh
YAD_WIDTH=200
YAD_HEIGHT=200
BOTTOM=false
DATE="$(date +"%a %d %H:%M")"
```

If you use a tiling window manager you should enable floating for `yad`. This example is for `i3wm`:

```ini
for_window [class="Yad"] floating enable
```


## Module

```ini
[module/popup-calendar]
type = custom/script
exec = ~/polybar-scripts/popup-calendar.sh
interval = 5
click-left = ~/polybar-scripts/popup-calendar.sh --popup
```
