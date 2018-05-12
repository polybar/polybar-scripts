# Script: system-nvidia-bbswitch

A shell script that shows if the NVIDIA card is used or not.

This only will work for notebook users with a dedicated NVIDIA card and an Intel graphics card. Click the left mouse button to open the `nvidia-settings`.


## Dependencies

* [bbswitch](https://github.com/Bumblebee-Project/bbswitch): You will probably find `bbswitch` in the repository of your distribution.


## Module

```ini
[module/system-nvidia-bbswitch]
type = custom/script
exec = ~/polybar-scripts/system-nvidia-bbswitch.sh
interval = 5
click-left = "optirun -b none nvidia-settings -c :8"
```
