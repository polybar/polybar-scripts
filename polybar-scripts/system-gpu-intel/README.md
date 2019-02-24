# Script: system-gpu-intel

A script that shows the Intel GPU consumption. It is calculated on the current frequency.


## Dependencies

* `intel_gpu_frequency` from `intel-gpu-tools`
* `bc`


## Configuration

You have to add the `intel_gpu_frequency` command to the `/etc/sudoers` NOPASSWD of your user:

```
user ALL=(ALL) NOPASSWD: /usr/bin/intel_gpu_frequency
```


## Module

```ini
[module/system-gpu-intel]
type = custom/script
exec = ~/polybar-scripts/system-gpu-intel.sh
interval = 20
```
