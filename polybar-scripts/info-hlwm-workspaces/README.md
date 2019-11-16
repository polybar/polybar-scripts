# Script: info-hlwm-workspaces

Displays all herbstluftwm workspaces with support for all workspace states (`focused`, `visible`, `occupied`, `empty`, `urgent`).

![info-hlwm-workspaces](screenshots/1.png)


## Dependencies

* `herbstluftwm` running as your WM


## Configuration

On its own the script is pretty plain as there are no colors. There are a bunch of <kbd>TODO</kbd> comments where you can `echo` [Formatting Tags](https://github.com/jaagr/polybar/wiki/Formatting#format-tags) for certain workspace state to make it more colorful and help you actually distinguish the different states.


## Module

```ini
[module/info-hlwm-workspaces]
type = custom/script
exec = ~/polybar-scripts/info-hlwm-workspaces.sh
tail = true
scroll-up = herbstclient use_index -1 --skip-visible &
scroll-down = herbstclient use_index +1 --skip-visible &
```
