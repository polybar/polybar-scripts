# Script: CriticalBatteryState

A short script witch send you a noticifacion if the barrery state is less than `X` percent.

## Dependencies

None

## Module

```ini
[module/CriticalBatteryState]
type = custom/script
interval = 20
exec = ./CriticalBatteryState.sh
```
