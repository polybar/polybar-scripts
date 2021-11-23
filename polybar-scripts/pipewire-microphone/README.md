# Script: pipewire-microphone

A script for showing and toggling the mute state of the PipeWire default microphone.


## Dependencies

* pactl (libpulse)
* pw-cat (pipewire)


## Module

``` ini
[module/pipewire-microphone]
type = custom/script
exec = $HOME/.config/polybar/polybar-scripts/polybar-scripts/pipewire-microphone/pipewire-microphone.sh
tail = true
click-left = $HOME/.config/polybar/polybar-scripts/polybar-scripts/pipewire-microphone/pipewire-microphone.sh --toggle &
```
