# Script: isrunning-noisetorch

A script that outputs an icon if noisetorch is loaded as a pulseaudio module 

![isrunning-noisetorch](screenshots/1.png)


## Dependencies

* `Pulseaudio` Can be obtained from [pulseaudio/pulseaudio](https://github.com/pulseaudio/pulseaudio)

## Module

```ini
[module/isrunning-noisetorch]
type = custom/script

exec     = ~/.config/polybar/modules/isrunning-noisetorch.sh
interval = 20
format  = <label>
label   = %output%
```
