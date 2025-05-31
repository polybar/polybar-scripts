
#!/bin/sh

envFile=~/.config/polybar/scripts/polybar-buds/env.sh


playback_icon="${PLAYBACK_ICON}"
mic_icon="${MIC_ICON}"
disconnected_icon="${DISCONNECTED_ICON}"

changeMode() {
  sed -i "s/AUDIO_MODE=$1/AUDIO_MODE=$2/g" $envFile 
  AUDIO_MODE=$2
  echo $AUDIO_MODE
}

changeConnected() {
  sed -i "s/BT_HEADSET_CONNECTED=$1/BT_HEADSET_CONNECTED=$2/g" $envFile 
  BT_HEADSET_CONNECTED=$2
  echo $BT_HEADSET_CONNECTED
}

case $1 in 
  toggle) 
    if [ "$AUDIO_MODE" = playback ];
    then
      changeMode "$AUDIO_MODE" mic
      pacmd set-card-profile $BT_HEADSET_NAME handsfree_head_unit
    else
      changeMode "$AUDIO_MODE" playback
      pacmd set-card-profile $BT_HEADSET_NAME a2dp_sink
    fi
    ;;
  init)
    if [ "$BT_HEADSET_CONNECTED" = false ];
    then
      printf $disconnected_icon
    else
      case $AUDIO_MODE in
        playback)
          printf $playback_icon
          ;;
        mic)
          printf $mic_icon
          ;;
      esac
    fi
    ;;
  connect)
    case $BT_HEADSET_CONNECTED in 
      true)
        bluetoothctl disconnect $BT_HEADSET_MAC 
        changeConnected "$BT_HEADSET_CONNECTED" false
        ;;
      false)
        bluetoothctl connect $BT_HEADSET_MAC
        changeConnected "$BT_HEADSET_CONNECTED" true
        ;;
    esac
    ;;
esac


