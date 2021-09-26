# Script: system-disk-monitor
A [shell script](https://github.com/makccr/disk-monitor-polybar) that checks the percentage of disk space used on /.

![system-drive-monitor](screenshots/1.png)

The drive being monitored can easily be changed, as well as the output of information. For example you can, easily have the script output the amount of space remaining, or space used, rather than a percentage of volume used.

By default the script is using icons from [Nerd Fonts](https://www.nerdfonts.com/), but this can easily be swapped out for something else as well. 

## Module 
```ini
[module/disk]
    type = custom/script
    interval = 1800
    format-prefix = "﫭" ;Change the icon here
    format = <label>
    exec = "~/.config/polybar/disk.sh"
```
