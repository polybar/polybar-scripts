# polybar-scripts

This is a community project. We write and collect scripts for Polybar! To find out how to write and use your own scripts, read [Polybars wiki](https://github.com/jaagr/polybar/wiki).

This repository is not an exact blueprint. I guess every script has to be customized to make your Polybar unique. We cannot guarantee that all scripts will work because many scripts are written for very specific purposes. But we're trying.

Your script isn't here yet? You have ideas to extend the scripts or descriptions? Send us your pull request.


## all colors are beautiful

[![updates-arch](polybar-scripts/updates-arch/screenshots/1.png)](polybar-scripts/updates-arch/)
[![temp-percore-colorful](polybar-scripts/temp-percore-colorful/screenshots/1.png)](polybar-scripts/temp-percore-colorful/)
[![temp-percore-colorful](polybar-scripts/temp-percore-colorful/screenshots/2.png)](polybar-scripts/temp-percore-colorful/)
[![hint-chess](polybar-scripts/hint-chess/screenshots/1.png)](polybar-scripts/hint-chess/)
[![inbox-reddit](polybar-scripts/inbox-reddit/screenshots/1.png)](polybar-scripts/inbox-reddit/)
[![openvpn-isrunning](polybar-scripts/openvpn-isrunning/screenshots/1.png)](polybar-scripts/openvpn-isrunning/)
[![temp-percore](polybar-scripts/temp-percore/screenshots/1.png)](polybar-scripts/temp-percore/)
[![temp-percore](polybar-scripts/inbox-imap/screenshots/1.png)](polybar-scripts/inbox-imap/)
[![ticker-btc](polybar-scripts/ticker-btc/screenshots/1.png)](polybar-scripts/ticker-btc/)


## See also these other user repositories:

* [vyachkonovalov/polybar-gmail](https://github.com/vyachkonovalov/polybar-gmail): A Polybar module to show unread messages from Gmail
* [0nse/now_playing](https://github.com/0nse/now_playing): Output the currently scrobbling song
* [dakuten/taskwarrior-polybar](https://github.com/dakuten/taskwarrior-polybar): merely just a script showing the most urgent task and allowing it to be marked done
* [quelotic/polybarModules](https://github.com/quelotic/polybarModules): scripts for mail and caffeine
* [vyp/scripts](https://github.com/vyp/scripts): A script to show focused, occupied, free and urgent herbstluftwm tags in polybar


## Development

It's a good idea to look at the [skeleton](skeleton/).

Most scripts are shell scripts. Use ShellCheck to check the code for possible errors. A good start to try [ShellCheck](https://www.shellcheck.net/) is their website.

Use `#` or `#1`, `#2` .. as icon replacement in your scripts. Everyone use anoter icon font. So let the user decide which icon he wants to use.

Remove your colors unless they have a special function. This way scripts remain customizable.
