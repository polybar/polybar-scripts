# Script: xfce4-presentation-mode.sh

This script can toggle [xfce4-power-manager][homepage] `presentation mode`
(inhibit the screensaver, hibernation, monitor timeout, etc.) and output a
message representing its current state to be diplayed in your bar.

This script is intended to be used in polybar, but it does work from any bash
shell. Shouldn't be difficult to use in `sh` if the bash-isms are converted.

## Dependencies

- bash
- xfce4-power-manager

## Configuration

Update `msg_on` and `msg_off` to display your desired output in each situation.

## Module

```ini
[module/xfce4-presentation-mode]
type = custom/script
exec = ~/polybar-scripts/xfce4-presentation-mode/xfce4-presentation-mode.sh
label = %output%
click-left = ~/polybar-scripts/xfce4-presentation-mode/xfce4-presentation-mode.sh toggle
```

[homepage]: https://docs.xfce.org/xfce/xfce4-power-manager/start
