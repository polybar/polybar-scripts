# Script: polybar-buds

## Dependencies

- pulseaudio
- pulseaudio-bluetooth
- bluez
- bluez-utils

## Configuration

1. Open the env.sh file. You should see BT_HEADSET_NAME and BT_HEADSET_MAC as empty values.

2. run the following command: pacmd list-cards

3. search for the card that represents your bluetooth device (device must be connected at this point)

4. copy the "name" value which should look like this (ignore the angle brackets and only copy the name):
   name: <bluez_card.C4_SS_3A_FF_63_50>

   Paste the name into the BT_HEADSET_NAME value in the env.sh file

5. run: bluetoothctl devices Connected

the output will look like so : Device D8:1F:22:9E:8B:30 HUAWEI FreeBuds Pro 3

6. Copy the MAC address portion (ex: D8:1F:22:9E:8B:30)

7. Paste the MAC address into the BT_HEADSET_MAC value in the env.sh

## Controls

Left-Click: will toggle between playback mode to mic mode
Right-Click: will disconnect or connect your bluetooth headset

## Module

ini ```
[module/headset]
type = custom/script
exec = source ~/.config/polybar/scripts/polybar-buds/env.sh && ~/.config/polybar/scripts/polybar-buds/polybar-buds.sh init
click-left = source ~/.config/polybar/scripts/polybar-buds/env.sh && ~/.config/polybar/scripts/polybar-buds/polybar-buds.sh toggle
click-right = source ~/.config/polybar/scripts/polybar-buds/env.sh && ~/.config/polybar/scripts/polybar-buds/polybar-buds.sh connect
env-PLAYBACK_ICON=#1
env-MIC_ICON=#2
env-DISCONNECTED_ICON=#3
label=" %output% "
interval=2

```

```
