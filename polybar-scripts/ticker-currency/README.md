# Script: ticker-currency

A script that displays the current currency rate for any currency.

![ticker-currency](screenshots/1.png)

## Module

```ini
[module/usdrate]
type = custom/script
exec = $HOME/.config/polybar/scripts/currencyrates.py usd kgs
interval=600
```

```ini
[module/rubrate]
type = custom/script
exec = $HOME/.config/polybar/scripts/currencyrates.py rub kgs
interval=600
```
