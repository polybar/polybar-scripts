# Script: pipewire-simple

A script to control pipewire with your mouse buttons and scroll wheel.

![pipewire-simple](screenshots/1.png)


## Dependencies

* `pactl`
* `pamixer`

Maybe `pavucontrol` is a good idea. In the example it is opened with a right mouse click.


## Module

```ini
[module/pipewire-simple]
type = custom/script
exec = ~/polybar-scripts/pipewire-simple.sh
interval = 3
click-right = exec pavucontrol &
click-left = ~/polybar-scripts/pipewire-simple.sh --mute &
scroll-up = ~/polybar-scripts/pipewire-simple.sh --up &
scroll-down = ~/polybar-scripts/pipewire-simple.sh --down &
```
