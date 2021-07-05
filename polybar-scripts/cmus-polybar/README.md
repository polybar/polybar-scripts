# cmus-polybar
A simple polybar module to show current song playing on cmus along with the progress icons


Demo
--------------
![Preview video](preview/preview.gif?raw=true)




How to use it
---------------

1. Install Material Design Icons and put it in the font-N line in polybar config. <br />
e.g.
``` 
font-2 = Material Design Icons:style=Regular:size=16;1
```

2. Clone this repo and check the location of cmus_wrapper.sh . Make sure the cmus_wrapper.sh is executable. Else:
```
chmod +x cmus_wrapper.sh
``` 

4. Create a polybar module with contents as following:
```
[module/cmus]
type = custom/script
tail = true
exec = sh location_of_cmus_wrapper/cmus_wrapper.sh 2> /dev/null
click-left = cmus-remote -u
click-right = cmus-remote -c
click-middle = cmus-remote -n
```

Enjoy!

Customizations
-------------------

You can pass one argument to cmus_wrapper.sh  in form of length of song to be displayed, within Exec line of polybar module.<br />
e.g. if you want your song to displayed at max of 10 characters, you can use this
```
 exec = sh location_of_cmus_wrapper/cmus_wrapper.sh 10 2>/dev/null
```
