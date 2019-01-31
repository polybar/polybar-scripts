#Scroll Song Names
Requirments
- Python
- zscroll [repo link](https://github.com/noctuid/zscroll)
This module will take the currently playing song/artist from pulseaudio and scroll the string "/// artist - song name" if it is longer than 20 characters, if not then it will display it statically. The character threshold can be changed by changing the thresh variable in the script.
```
[module/songnames]
type = custom/script
exec = ~/.scripts/mpdscroll.sh
format-underline = ${colors.secondary}
tail = true
```
![alt text](./screenshot-playing.png)
![alt text](./screenshot-paused.png)



