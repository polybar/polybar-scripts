# Script: popup-calendar

A small script that displays the date and opens a small popup calendar with YAD when clicked.

![popup-calendar](screenshots/1.png)


## Dependencies

* [`yad`](https://sourceforge.net/projects/yad-dialog/)
* `xdotool`


## Configuration

Change these values if you want:

```sh
width=200
height=200
bottom=0
date="$(date +"%a %d %H:%M")"
```


## Module

```ini
[module/popup-calendar]
type = custom/script
exec = ~/polybar-scripts/popup-calendar.sh
interval = 5
click-left = ~/polybar-scripts/popup-calendar.sh --popup
```
