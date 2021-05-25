# Script: isrunning-noisetorch

A script that outputs an icon if noisetorch is loaded as a pulseaudio module.

![isrunning-noisetorch](screenshots/1.png)


## Dependencies

* [NoiseTorch](https://github.com/lawl/NoiseTorch)


## Module

```ini
[module/isrunning-noisetorch]
type = custom/script
exec     = ~/.config/polybar/modules/isrunning-noisetorch.sh
interval = 20
```
