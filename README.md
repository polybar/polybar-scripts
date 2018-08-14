# polybar-scripts

[![Build Status](https://travis-ci.org/x70b1/polybar-scripts.svg?branch=master)](https://travis-ci.org/x70b1/polybar-scripts)
[![GitHub contributors](https://img.shields.io/github/contributors/x70b1/polybar-scripts.svg)](https://github.com/x70b1/polybar-scripts/graphs/contributors)
[![license](https://img.shields.io/github/license/x70b1/polybar-scripts.svg)](https://github.com/x70b1/polybar-scripts/blob/master/LICENSE)

This is a community project. We write and collect scripts for Polybar!

To find out how to write and use your own scripts, read [Polybars wiki](https://github.com/jaagr/polybar/wiki).

This repository is not an exact blueprint. I guess every script has to be customized to make your Polybar unique. We cannot guarantee that all scripts will work because many scripts are written for very specific purposes. But we're trying.

Your script isn't here yet? You have ideas to extend the scripts or descriptions? Send us your pull request or join us on freenode's `#polybar`.


## Hall of Fame

Is this your first time here? You should definitely take a look at these scripts:

* [battery-combined-udev](polybar-scripts/battery-combined-udev)
* [openweathermap-fullfeatured](polybar-scripts/openweathermap-fullfeatured)
* [player-mpris-tail](polybar-scripts/player-mpris-tail)
* [pulseaudio-tail](polybar-scripts/pulseaudio-tail)
* [system-usb-udev](polybar-scripts/system-usb-udev)
* [updates-arch-combined](polybar-scripts/updates-arch-combined)
* [info-hackspeed](polybar-scripts/info-hackspeed)


## all colors are beautiful

[![updates-arch-combined](polybar-scripts/updates-arch-combined/screenshots/1.png)](polybar-scripts/updates-arch-combined/)
[![system-cpu-temppercore](polybar-scripts/system-cpu-temppercore/screenshots/1.png)](polybar-scripts/system-cpu-temppercore/)
[![notification-chess](polybar-scripts/notification-chess/screenshots/1.png)](polybar-scripts/notification-chess/)
[![inbox-reddit](polybar-scripts/inbox-reddit/screenshots/1.png)](polybar-scripts/inbox-reddit/)
[![isrunning-openvpn](polybar-scripts/isrunning-openvpn/screenshots/1.png)](polybar-scripts/isrunning-openvpn/)
[![inbox-imap-python](polybar-scripts/inbox-imap-python/screenshots/1.png)](polybar-scripts/inbox-imap-python/)
[![openweathermap-fullfeatured](polybar-scripts/openweathermap-fullfeatured/screenshots/1.png)](polybar-scripts/openweathermap-fullfeatured/)
[![ticker-btceur](polybar-scripts/ticker-btceur/screenshots/1.png)](polybar-scripts/ticker-btceur/)
[![player-mpris-simple](polybar-scripts/player-mpris-simple/screenshots/1.png)](polybar-scripts/player-mpris-simple/)
[![battery-combined-tlp](polybar-scripts/battery-combined-tlp/screenshots/1.png)](polybar-scripts/battery-combined-tlp/)
[![info-projecthamster](polybar-scripts/info-projecthamster/screenshots/1.png)](polybar-scripts/info-projecthamster/)
[![system-usb-udev](polybar-scripts/system-usb-udev/screenshots/1.png)](polybar-scripts/system-usb-udev/)
[![system-usb-udev](polybar-scripts/system-usb-udev/screenshots/2.png)](polybar-scripts/system-usb-udev/)
[![openweathermap-simple](polybar-scripts/openweathermap-simple/screenshots/1.png)](polybar-scripts/openweathermap-simple/)
[![info-pingrtt](polybar-scripts/info-pingrtt/screenshots/3.png)](polybar-scripts/info-pingrtt/)
[![info-ssh-sessions](polybar-scripts/info-ssh-sessions/screenshots/1.png)](polybar-scripts/info-ssh-sessions/)
[![openweathermap-detailed](polybar-scripts/openweathermap-detailed/screenshots/1.png)](polybar-scripts/openweathermap-detailed/)
[![info-hackspeed](polybar-scripts/info-hackspeed/screenshots/1.png)](polybar-scripts/info-hackspeed/)
[![info-xampp](polybar-scripts/info-xampp/screenshots/1.png)](polybar-scripts/info-xampp/)
[![player-mpris-tail](polybar-scripts/player-mpris-tail/screenshots/1.png)](polybar-scripts/player-mpris-tail/)
[![info-redshift-temp](polybar-scripts/info-redshift-temp/screenshots/1.png)](polybar-scripts/info-redshift-temp/)
[![info-trash](polybar-scripts/info-trash/screenshots/1.png)](polybar-scripts/info-trash/)
[![pulseaudio-rofi](polybar-scripts/pulseaudio-rofi/screenshots/1.png)](polybar-scripts/pulseaudio-rofi/)
[![info-twitch-countdown](polybar-scripts/info-twitch-countdown/screenshots/1.png)](polybar-scripts/info-twitch-countdown/)
[![info-twitch-countdown](polybar-scripts/info-twitch-countdown/screenshots/2.png)](polybar-scripts/info-twitch-countdown/)
[![info-todotxt](polybar-scripts/info-todotxt/screenshots/1.png)](polybar-scripts/info-todotxt/)


## See also these other user repositories:

* [vyachkonovalov/polybar-gmail](https://github.com/vyachkonovalov/polybar-gmail): A Polybar module to show unread messages from Gmail
* [0nse/now_playing](https://github.com/0nse/now_playing): Output the currently scrobbling song
* [dakuten/taskwarrior-polybar](https://github.com/dakuten/taskwarrior-polybar): merely just a script showing the most urgent task and allowing it to be marked done
* [quelotic/polybarModules](https://github.com/quelotic/polybarModules): scripts for mail and caffeine
* [vyp/scripts](https://github.com/vyp/scripts): A script to show focused, occupied, free and urgent herbstluftwm tags in polybar
* [willHol/polybar-crypto](https://github.com/willHol/polybar-crypto): A polybar script that displays the price of crypto-currencies
* [DanaruDev/UnseenMail](https://framagit.org/DanaruDev/UnseenMail): Polybar Python script for viewing unread email from multi accounts
* [drdeimos/polybar_another_battery](https://github.com/drdeimos/polybar_another_battery): Simple battery charge level watcher with notifications (libnotify)
* [zemmsoares/polynews](https://github.com/zemmsoares/polynews): read news on your polybar


##  Setup

* Save the script of your choice somewhere at `~/.config/polybar/`.
* Copy the module settings into your configuration file.
* Replace the appropriate icon strings in the script (e.g. replace `#1` with `🎉`).
