# Script: pulseaudio-microphone

A script that shows if the PulseAudio default source (microphone) is muted or not.

Use left click to toggle the state.

## Module

```ini
[module/pulseaudio-microphone]
type = custom/script
exec = ~/polybar-scripts/pulseaudio-microphone.sh
tail = true
click-left = ~/polybar-scripts/pulseaudio-microphone.sh --toggle &
scroll-up = ~/polybar-scripts/pulseaudio-microphone.sh --increase &
scroll-down = ~/polybar-scripts/pulseaudio-microphone.sh --decrease &
```
