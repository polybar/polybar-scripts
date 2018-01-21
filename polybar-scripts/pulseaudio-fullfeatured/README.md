# Script: pulseaudio-fullfeatured

A script to control PulseAudio very easy and fast.

The script uses polybar's tail function to display the adjustments in real time.


## Dependencies

* `pamixer`

Maybe `pavucontrol` is a good idea. In the example it is opened with a right mouse click.


## Module

```ini
[module/pulseaudio-fullfeatured]
type = custom/script
exec = ~/polybar-scripts/pulseaudio-fullfeatured.sh
tail = true
click-right = exec pavucontrol &
click-left = ~/polybar-scripts/pulseaudio-fullfeatured.sh --mute
scroll-up = ~/polybar-scripts/pulseaudio-fullfeatured.sh --up
scroll-down = ~/polybar-scripts/pulseaudio-fullfeatured.sh --down
```
