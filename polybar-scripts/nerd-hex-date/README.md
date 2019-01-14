# Script: HexDate

Print the current date in a Hexformat like
![skeleton](screenshots/hex-date.png)
Inspired by [this](https://linux.pictures/projects/one-root-to-rule-them-all-hex-calendar-2019)

## Dependencies

None

## Configuration

Look at the ugly script. But it works. 

## Module

```ini
[module/HexDate]
type = custom/script
interval = 10
label = X %output%
exec = ./hexdate.sh
```
