# Script: cpu-frequency

A script that shows the current CPU frequency. If the current CPU frequency is greater than the CPU max MHz, you’ll see a nice little plus sign to indicate Turbo Boost (or whatever your brand of CPU uses for fancy marketing jargon).

![cpu-frequency](screenshots/1.png)

## Module

```ini
[module/cpu-frequency]
type = custom/script
exec = ~/.config/scripts/cpu-frequency.sh
interval = 1
```

