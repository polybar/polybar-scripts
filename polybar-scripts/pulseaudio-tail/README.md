# Script: pulseaudio-tail

A script to control PulseAudio.

The script uses polybar's tail function to display the adjustments in real time. Please note that there is already a polybar module [`pulseaudio`](https://github.com/jaagr/polybar/wiki/Module:-pulseaudio) for this task.


## Dependencies

* `pamixer`

Maybe `pavucontrol` is a good idea. In the example it is opened with a right mouse click.


## Module

```ini
[module/pulseaudio-tail]
type = custom/script
exec = ~/polybar-scripts/pulseaudio-tail.sh
tail = true
click-right = exec pavucontrol &
click-left = ~/polybar-scripts/pulseaudio-tail.sh --mute &
scroll-up = ~/polybar-scripts/pulseaudio-tail.sh --up &
scroll-down = ~/polybar-scripts/pulseaudio-tail.sh --down &
```
