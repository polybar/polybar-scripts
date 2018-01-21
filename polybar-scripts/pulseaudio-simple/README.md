# Script: pulseaudio-simple

A script that shows the PulseAudio volume.


## Dependencies

* `pamixer`


## Module

```ini
[module/pulseaudio-simple]
type = custom/script
exec = ~/polybar-scripts/pulseaudio-simple.sh
interval = 3
```
