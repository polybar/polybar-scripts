# Script: date-calendar

Script that shows date and when clicked it opens small popup calendar with Yad

![date-calendar](screenshots/1.png)


## Dependencies

* [Yad](https://sourceforge.net/projects/yad-dialog/)
* xdotool


## Configuration

For top panel set `bottom=0`, for bottom panel `bottom=1`.

Example:

```sh
width=200
height=200
bottom=0
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
