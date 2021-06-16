# Script: tarjaturunen-coloursinthedark

A script that shows a button and opens in youtube the album colours in the dark by Tarja Turunen


## Module

```ini
[module/tarja-coloursinthedark]
type = custom/script
exec = echo " Turunen"
interval = 2400
click-left = "firefox -url https://www.youtube.com/watch?v=MS51m6rPyFo"

format = <label>
format-prefix = " Tarja "
format-prefix-foreground = #ffffff
format-prefix-background = #333333

format-foreground = #000000
format-background = #880000
```
