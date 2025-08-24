# bspwm-node-flags

This script was originally written in [`fish`](https://fishshell.com/), so a
fish script has been included, but I have rewritten it in `python` so that it's
more shell agnostic - `python` is more common than `fish`. This module displays
a bookmark icon, alongside a single character to be used in conjunction with
[`bspwm`](https://github.com/baskerville/bspwm) to show flags of the focused
node.

The following code can be modified if you'd prefer different characters for the
name of the flags. I have chosen `S` for sticky, `X` for lock, `M` for marked &
`P` for private. There are other flags on the node, but these are all that are
currently coded.

```python
flag_states = {
    'S': node_tree['sticky'],
    'X': node_tree['locked'],
    'M': node_tree['marked'],
    'P': node_tree['private']
}
```

`chmod +x $HOME/.config/polybar/scripts/bspwm-node-flags`

`chmod +x $HOME/.config/polybar/scripts/bspwm-node-flags.py`

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
