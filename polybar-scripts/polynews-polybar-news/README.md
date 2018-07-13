![Polynews Example](https://i.imgur.com/ALjgqS3.jpg)

The idea is in the future to have several scripts for different news sites

[![sample screenshot](http://i.imgur.com/RmbQrjS.png)](http://i.imgur.com/HWvaTtb.png)
[![sample screenshot](http://i.imgur.com/XkxGKED.png)](https://i.imgur.com/Z2guyDz.png)

## Get API Key

Register [here](https://bonobo.capi.gutools.co.uk/register/developer) for a TheGuardian API key (free for non-profit projects)  
Edit polynews-theguardian.py, replace with your API key ```api_key = "API-KEY-HERE"``` 

## Module
```ini
[module/polynews]
type = custom/script
exec = ~/polybar-scripts/polynews/polynews-theguardian.py
interval = 30
format-prefix = " "
```

## Additional formatting
```ini
[module/polynews]
;type = custom/script
;exec = ~/polybar-scripts/polynews/polynews-theguardian.py
;interval = 30
;format-prefix = " "
label-maxlen = 50
```


## Icon
Icon from example ( Font Awesome 5 Free )
```ini
font-0 = Font Awesome 5 Free:style=Regular:pixelsize=8;0
```
