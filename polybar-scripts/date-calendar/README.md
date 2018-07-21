# Script: date-calendar

Script that shows date and when clicked it opens small popup calendar either with Yad or Rofi

![date-calendar](screenshots/1.png)


## Dependencies

* [Yad](https://sourceforge.net/projects/yad-dialog/) or [Rofi](https://github.com/DaveDavenport/rofi)
* xdotool


## Configuration

For top panel set `bottom=0`, for bottom panel `bottom=1`. Popup method can be either `rofi` or `yad` in the `popup` variable. Yad is recommended. If Rofi is used then Rofi theme must be set in `rofitheme` variable. Theme cannot be side/top-bar(like dmenu) because location needs to be set.

Example:

```sh
width=200
height=200
bottom=0
popup="yad"
rofitheme="/usr/share/rofi/themes/Arc-Dark.rasi"
date="$(date +"%a %d %H:%M")"
```


## Module

```ini
[module/date-calendar]
type = custom/script
exec = ~/polybar-scripts/date-calendar.sh
interval = 1
click-left = ~/polybar-scripts/date-calendar.sh click
```
