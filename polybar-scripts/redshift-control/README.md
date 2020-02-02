# Redshift Control

Change, display temperature and on/off redshift.

![Screenshot of Redshift Control](https://raw.githubusercontent.com/polybar/polybar-scripts/master/polybar-scripts/redshift-control/screenshots/redshift-control.png)

### Usage
Scroll to increase/decrease temperature <br>
Left-click to on/off redshift

```
[module/redshift]
type = custom/script
format-prefix = " "  
exec = source ~/polybar-scripts/env.sh && ~/polybar-scripts/redshift-control.sh temperature 
click-left = source ~/polybar-scripts/env.sh && ~/polybar-scripts/redshift-control.sh toggle 
scroll-up = source ~/polybar-scripts/env.sh && ~/polybar-scripts/redshift-control.sh increase
scroll-down = source ~/polybar-scripts/env.sh && ~/polybar-scripts/redshift-control.sh decrease
interval=0.5
```

