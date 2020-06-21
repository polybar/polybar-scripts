# polybar-optimus-manager

A script that shows the current GPU in use, given that the GPUs are managed by [optimus-manager](https://github.com/Askannz/optimus-manager). The script also allows for switching GPU in one click, just **please** be aware that this will log you out of your session without asking for confirmation. See below how this can be enabled.

![polybar-optimus-manager](screenshots/1.png)

## Configuration

1. Make sure you have `enable-ipc=true` in the polybar config file.
2. Edit the script and change the "Configuration" part to your liking. This is not necessary if you don't use the "Hybrid" mode in optimus-manager and you're happy with the default outputs. 
3. (Optional, enables switching GPU when the module is left-clicked). Uncomment the line `;click-left = polybar-msg hook info-optimus-manager 2` in the module.


## Module

```ini
[module/info-optimus-manager]
type = custom/ipc
hook-0 = ~/polybar-scripts/info-optimus-manager.sh
hook-1 = ~/polybar-scripts/info-optimus-manager.sh --switch
initial = 1
;click-left = polybar-msg hook info-optimus-manager 2
```

