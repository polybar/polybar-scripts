# Script: Ipfinder

A script that tells you whether you're connected to a VPN and your public IP address.

---

1. Attempts to retrieve your public IP address and country of origin from the free but limited `ipinfo.io` service. 
2. If that fails, it will retrieve it from `ifconfig.co` instead. A failure may happen when you've reached your monthly threshold of free API requests. 
3. Finally, if that also fails, it will print your local IP address. Furthermore, assuming a tunnel is always created for a VPN connection, it will tell you whether you're currently connected to a VPN service or not: 

![image-20200607213450093](screenshots/connected_vpn_up.png)

![](screenshots/connected_vpn_down.png)

If there is no Internet connection, it will show a broken link accordingly:

![image-20200607213526975](screenshots/disconnected.png)

## Dependencies

```bash
sudo apt install -y curl jq iproute2
```

### Fonts

To display the icons properly, you'll need [Font Awesome](https://github.com/FortAwesome/Font-Awesome) which you must also refer to in your `[bar/...]` module, e.g,:

```ini
font-0 = ...
font-1 = Font Awesome 5 Free:style=Solid:pixelsize=9; 2
font-2 = Font Awesome 5 Free:style=Regular:pixelsize=9; 2
font-3 = Font Awesome 5 Brands:pixelsize=9; 2
font-4 = Font Awesome 5 Free:style=Solid:pixelsize=7; 2
```

Alternatively, you can use your own custom font icons by modifying the script at:

* line 34 (VPN down), 
* line 38 (VPN up) and 
* line 56 (No Internet connection.)

## Module

```ini
[module/network]
type = custom/script
exec = ~/.config/polybar/ipfinder.sh
tail = true
```

Replace `exec` value with the path of this script. I usually store them in a `~/.config/scripts` directory, but I've seen a lot of people use `~/.config/polybar` instead. **Remember to make it executable.**

I also encourage you to add a `click-left` event if you're using a VPN service. For example, I use Mullvad VPN:

```ini
...
tail = true
click-left = '/opt/Mullvad VPN/mullvad-vpn' &
```

