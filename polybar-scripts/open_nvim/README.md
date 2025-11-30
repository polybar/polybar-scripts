# Script: battery-combined-shell

A shell script that open nvim after you choise folder to open.

Use font Material Icons
```ini
font-1 = Material Icons:style=Regular:size=35;3
```
## Dependencies
- rofi
- nvim
- [nerdfonts](https://www.nerdfonts.com/) 

## Module
```ini
[module/open_nvim]
type = custom/text
content = "%{T1} %{T-}"
content-background = ; choise your color
content-foreground = ; choise your color
content-padding = 1
click-left = run_nvim.sh &
```

## Configure 
in ```run_nvim.sh``` set your terminal and rofi config
