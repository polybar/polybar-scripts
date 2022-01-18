# dunstctl, a dunst controller script & module

This script is written in [`fish`](https://fishshell.com/), and displays a
bookmark icon, alongside a single character to be used in conjunction with
[`bspwm`](https://github.com/baskerville/bspwm) to show flags of the focused
node.

The following code can be modified if you'd prefer different characters for the
name of the flags. I have chosen `S` for sticky, `X` for lock, `M` for marked &
`P` for private. There are other flags on the node, but these are all that are
currently coded.
```sh
# Filter out false flags, and prepend a character to act as the name.
set flags (string match -ie true \
    'S:'$flag_states[1] 'X:'$flag_states[2] \
    'M:'$flag_states[3] 'P:'$flag_states[4])
```

`chmod +x $HOME/.config/polybar/scripts/bspwm-node-flags` (or the path of your
choice.)

## Preview

![bspwm-node-flags](bspwm-node-flags.gif)

## Example module

```ini
[module/bspwm-node-flags]
exec = $HOME/.config/polybar/scripts/bspwm-node-flags
format-foreground = '#fabd2f'
tail = true
type = custom/script

```
