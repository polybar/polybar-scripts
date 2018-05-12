# Script: system-gpu-intel

A script that shows the Intel GPU consumption. It is calculated on the current frequency.


## Dependencies

* `intel_gpu_frequency` from `intel-gpu-tools`

You have to run `intel_gpu_frequency` with root privileges. Use `sudo` for that.


## Module

```ini
[module/system-gpu-intel]
type = custom/script
exec = ~/polybar-scripts/system-gpu-intel.sh
interval = 20
```
