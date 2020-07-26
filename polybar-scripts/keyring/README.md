# Polybar-keyring

A small collection of scripts that (un)locks a keyring (e.g. gnome-keyring)
based on https://github.com/r-lib/keyring

## Dependencies

R package
Install the package from CRAN:

```r
install.packages("keyring")
```

## Module

```ini
[module/keyring]
type = custom/script
exec = ~/polybar-scripts/polybar-keyring/keyring.sh
click-left = notify-send "(un)locking gnome-keyring" && ~/polybar-scripts/polybar-keyring/keyring_toggle.r
interval = 5
```

## Usage 
1. Install the Dependencies
2. Insert the module in your polybar config
3. Update the path in polybar-keyring.conf