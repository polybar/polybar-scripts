# info-timezone
A custom ![polybar](https://github.com/polybar/polybar) script to easily switch the timezone of the date displayed.

![tz](tz.gif)


## Configuration

Add the timezones of your choice inside `info-timezone.sh`. You can add as many timezones as you desire.

To change the date format, replace `FORMAT` variable in info-timezone.sh with the format of your choice.

Formatting sequences can be found in `man date`.

## Module

```ini
[module/info-timezone]
type = custom/script
exec = ~/.config/polybar/info-timezone.sh
tail = true
click-left = kill -USR1 %pid%
```

