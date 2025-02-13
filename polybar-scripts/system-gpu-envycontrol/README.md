# Script: system-gpu-envycontrol

A script that shows the current GPU in use, given that the GPUs are managed by [envycontrol](https://github.com/bayasdev/envycontrol).

The script also allows for switching GPU in one click.
Be aware that this will log you out of your session without asking for confirmation.


## Configuration

Set `hybrid_switching` to `1` if the system switches between hybrid and nvidia.
Otherwise the system switches between intel and nvidia.


## Module

```ini
[module/system-gpu-optimus]
type = custom/script
exec = ~/polybar-scripts/system-gpu-optimus.sh
interval = 1200
click-right = ~/polybar-scripts/system-gpu-optimus.sh --switch
```
