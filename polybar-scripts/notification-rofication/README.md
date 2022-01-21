# A script for polybar to display rofications.

This script will display a bell icon if there are no rofifications. If there are rofifications, it will display a *ringing* bell icon with the number of rofifications next to it.

Screenshots:

![picture alt](https://github.com/imsosora/polybar-rofication/blob/main/images/no-notifications.jpg "No notifications")
![picture alt](https://github.com/imsosora/polybar-rofication/blob/main/images/two-notifications.jpg "Two notifications")

Left-clicking the icon will spawn rofification-gui.

## How to install

1. Copy bin/rofication-status to ~/bin, make sure ~/bin is in your $PATH. We don't want the styles in the output, just the number of notifications.
2. Copy the script in .config/polybar/scripts to ~/.config/polybar/scripts (or whatever location you prefer). 
3. Be sure to make both executable, and check that rofification-status gives the correct output (an integer).
4. Add this to your polybar config: 
    ```
    [module/rofication-status]
    type = custom/script
    exec = ~/.config/polybar/scripts/rofication.sh
    click-left = ~/.config/polybar/scripts/rofication.sh --show &
    ```
5. The icons used are from [Material Design Icons](https://github.com/google/material-design-icons "Material Design Icons"), so make sure to install the font and name it in your polybar config: `font-3 = Material Design Icons:pixelsize=16;1`

See also [this blog post](https://zatsuda.wordpress.com/2022/01/21/regolith-how-to-rofication-module-for-polybar/ "Blog Post").
