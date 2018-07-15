# Script: system-nvidia-smi

A script that shows the NVIDIA GPU utilization.


## Dependencies

* `nvidia-smi`


## Configuration

There are several `--query-gpu=` values. Use nvidia-smi `--help-query-gpu` for a complete list and description. The most notable are `fan.speed`, `memory.used`, `memory.total`, `driver_version`, `power.draw`, `pstate`.

If you don't need custom labelling use instead:
`nvidia-smi --query-gpu=utilization.gpu --format=csv,noheader`


## Module

```ini
[module/system-nvidia-smi]
type = custom/script
exec = ~/polybar-scripts/system-nvidia-smi.sh
interval = 10
```
