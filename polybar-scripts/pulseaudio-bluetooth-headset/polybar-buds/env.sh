#sets playback or mic mode. DO NOT TOUCH. Toggle is handled automatically by polybar
export AUDIO_MODE=playback
#sets connection state of mic. DO NOT TOUCH. Handled automatically.
export BT_HEADSET_CONNECTED=true





#Enter the name of the bluetooth headset. It is usually just the MAC Adress of the bluetooth device.
# To find the "name" of the bluetooth device run the following command:
#pacmd ls

#All of the pulse audio channels will be listed. You just need to find the channel for your device. The name that you are looking for will look something like this
#name: <bluez_card.C4_SS_3A_FF_63_50>

#ignore the angle braces and copy the name inside of them.
export BT_HEADSET_NAME=SOME_VALUE

#run bluetoothctl devices to get a list of devices. Grab the mac address of your device and paste it to the field below
#if no devices come up, run bluetoothctl scan on and then run bluetoothctl devices(assuming you have already done bluetooth setup in any capacity).
export BT_HEADSET_MAC=SOME_VALUE

