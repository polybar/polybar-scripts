# Polybar-keyring

A small collection of scripts that (un)locks a keyring (e.g. gnome-keyring)
based on https://github.com/r-lib/keyring

![keyring-unlocked](screenshots/unlocked.png)
![notify](screenshots/notification.png)
![keyring-locked](screenshots/locked.png)

## Motivation

I use [zx2c4 pass](https://www.passwordstore.org/) to store all my passwords
and since I am too lazy to always enter my passphrase before I can use it
I save it on the gnome-keyring.

Thus, I was searching for an easy way to lock/unlock my keyring
w/o even firing up a command line.

And sometimes you just want to be sure that your keyring is locked.

So enjoy!

Feel free to add some extra feature. I won't add more since
it now perfectly fits to my use case.

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

## Installation
1. Install the Dependencies
2. Insert the module in your polybar config
3. Change the path in polybar-keyring.conf
