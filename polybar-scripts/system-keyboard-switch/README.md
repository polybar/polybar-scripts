# Script: system-keyboard-switch

A shell script that shows the current keyboard layout and change it to another one


## Module

```ini
[module/system-keyboard-switch]
type = custom/script
exec = ~/polybar-scripts/system-keyboard-switch.sh
tail = true
format-prefix = ""
format-prefix-foreground = #00ff00
format-underline = #ff0000
click-left = "kill -USR1 $(pgrep --oldest --parent %pid%)"
interval = 3
```
## Customization

By default there is only `fr` or `us` layout.
If you need to switch between other ones just change the script with your needed layouts.

## Moreover

I made a special module with script that do the trick.
Alongside with the module `xkeyboard` it looks great in that order of module: `[ ... system-keyboard-menu xkeyboard ... ]`

```ini
[module/xkeyboard]
type = internal/xkeyboard
blacklist-0 = num lock

format-prefix = ""
format-prefix-foreground = ${colors.foreground-alt}

label-layout = %layout%
label-layout-underline = ${colors.secondary}

label-indicator-padding = 2
label-indicator-margin = 1
label-indicator-background = ${colors.secondary}
label-indicator-underline = ${colors.secondary}

[module/system-keyboard-menu]
type = custom/menu

expand-right = true

format-spacing = 1

label-open = "  "
label-open-foreground = #00ff00
label-close =  cancel
label-close-foreground = #00ff00
label-separator = |
label-separator-foreground = ${colors.foreground-alt}

menu-0-0 = us
menu-0-0-exec = setxkbmap us -model pc105
menu-0-1 = fr
menu-0-1-exec = setxkbmap fr -model pc105

menu-2-0 = cancel
menu-2-0-exec = #mykeyboard.open.0

```
