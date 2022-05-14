# ixwindow – icon xwindow module for Polybar


## About

`ixwindow` is an enhanced version of standard `xwindow` polybar module. 
The main feature is icon for active window, but it also allows you more 
customization of printing window info. This is what `ixwindow` looks like in work:

<p align="center">
  <img src="example.gif" alt="animated" />
</p>


**Note:** basically, it doesn't depend on polybar one bit, it can be used 
with any other bar as well, you just need to implement the same behavior,
as polybar's `tail = true`.


## Dependencies
- `bash`
- `bspc`
- `xdotool`
- `xdo` (can be replaced with `xdotool`)
- `imagemagick` (for converting `.png` icons to `.jpg`)
- `g++` (for compiling `polybar-xwindow-icon`)

## Installation

Just modify `install.sh` script for your case and run it. Things to modify:
- background color of polybar bar
- size of icon
- coordinates for icon
- path to `polybar-icons` folder (note: it makes sense to keep it 
around `.config/polybar` folder, so you won't lose your custom icons, 
if you have them)
- change `GAP` constant in `ixwindow` script 

You will also need to add the following to your polybar `config` file:

```dosini
[module/ixwindow]
type = custom/script
exec = /path/to/ixwindow
tail = true
```

and put it somewhere on bar, for example, add it right next to `bspwm`: 
`modules-left = bspwm ixwindow`.

**Note:** If you want to reinstall `ixwindow`, like if you need to change the 
configuration of the module, you just need to run `install.sh` with the updated 
parameters. But old icons won't remove, so if you need to delete them, you will 
have to do that manually.

**Note:** For relaunching polybar, you will need to use something like 
`killall polybar && launchpolybar &`, so the previous instance of `ixwindow` 
will be killed (I am currently trying to find a workaround for it)


## Generating icons

`ixwindow` uses the output of `xprop` for generating icons automatically. 
Most of the times it works, but for some applications, for example, Spotify,
it doesn't work. Then, if you want to have an icon for these applications, you 
have to add them yourself. 

### Adding custom icons

Sometimes it's not possible to get icon using `xprop`, for example, it's the case with Spotify, 
so you might want to add them manually to your `polybar-icons` folder. To do that, you need to 
have `.png` version of icon, named as `WM_CLASS` (you can find it by running `xprop WM_CLASS` 
and selecting your app). Then run, the following command (requires `imagemagick`):
```bash
convert Spotify.png -resize 24x24 -background "#252737" -flatten -alpha off Spotify.jpg
```
**Note:** This method can be used for replacing default icons, generated with `xprop`.

## Known issues & limitations

- Lack of png support, but it will require compositor as well
- Untested on multimonitors system
- Manual specification, but seems to be unfixable at this point, since polybar doesn't 
support inserting images into bar for now
- Works only with bspwm 
- Working with relaunched polybar without `killall polybar`

## Thanks

### Inspired by  

https://github.com/MateoNitro550/xxxwindowPolybarModule

### With great help of

- https://stackoverflow.com/questions/54513419/putting-image-into-a-window-in-x11
- https://unix.stackexchange.com/questions/48860/how-to-dump-the-icon-of-a-running-x-program

