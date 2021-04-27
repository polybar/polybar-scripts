# Script: pipewire-microphone

A script for showing and toggling the mute state of the PipeWire default source (microphone). Based on [pulseaudio-microphone](https://github.com/polybar/polybar-scripts/tree/master/polybar-scripts/pulseaudio-microphone).

## Usage

Use the left click for toggling the state.

## Dependencies

- POSIX-compatible shell interpreter
- coreutils
- pactl (libpulse)
- awk
- sed
- pw-cat (pipewire) 

## Module

``` ini
[module/pipewire-microphone]
type = custom/script
exec = $HOME/.config/polybar/polybar-scripts/polybar-scripts/pipewire-microphone/pipewire-microphone.sh
tail = true
click-left = $HOME/.config/polybar/polybar-scripts/polybar-scripts/pipewire-microphone/pipewire-microphone.sh --toggle &
```
