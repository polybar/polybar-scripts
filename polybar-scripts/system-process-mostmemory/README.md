# Script: system-process-mostmemory

Show the process, which is using most memory,
and exceeds a configurable maximum.

Useful to e.g. get warned of a crashing website,
having a growing and blocking webbrowser in consequence.

Right click kills the process.



## Dependencies

Standard unix utilities. (ps, tail, sed)



## Configuration

exec = "~/.config/polybar/process-size.sh 1000000"
set the argument (1000000) to the minimum in kB.



## Module

```ini
[module/system-process-mostmemory]
type = custom/script
exec = "~/.config/polybar/system-process-mostmememory.sh 1000000"
tail = true
interval = 5
format-prefix = " "
click-right = "~/.config/polybar/system-process-kill.sh 1000000"
...
```
