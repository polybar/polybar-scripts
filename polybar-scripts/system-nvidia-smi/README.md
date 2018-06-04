# Script: system-nvidia-smi

A script that shows the NVIDIA GPU utilization.


## Dependencies

* `nvidia-smi`


## Module

```ini
[module/system-nvidia-smi]
type = custom/script
exec = ~/polybar-scripts/system-nvidia-smi.sh
interval = 10
```
