#!/bin/sh

PB_CRMS="#F22C40"
ANA_SINK=$(( $(pacmd list-sinks | grep "active port" | sed -n '\|analog-output|=')-1 ))
ANA_CMD="%{A4:pavol.sh -i ${ANA_SINK}:}%{A5:pavol.sh -d ${ANA_SINK}:}%{A1:pavol.sh -m ${ANA_SINK}:}"

volume_print() {

    # Analog output
    if [ "$(pamixer --sink $ANA_SINK --get-mute)" = true ]; then
#        ANA_ICON=""
        ANA_ICON="#1"
        ANA_VOL="%{F${PB_MUTE}}--%{F-}"
    else
        ANA_VOL="$(pamixer --sink $ANA_SINK --get-volume)"
        if [ "$ANA_VOL" -lt 30 ]; then
#            ANA_ICON=""
            ANA_ICON="#2"
        else
#            ANA_ICON=""
            ANA_ICON="#3"
        fi
        ANA_VOL="${ANA_VOL}%"
    fi

    if [ "$(pacmd list-sinks | grep "active port" | grep "analog" | sed 's/.*analog-output-\(.*\)>/\1/g')" == "headphones" ]
    then
#        ANA_ICON=""
        ANA_ICON="#4"
    fi
    ANA="${ANA_CMD}%{F${PB_CRMS}}${ANA_ICON}%{F-} $ANA_VOL%{A}%{A}%{A}"

    # HDMI output
    HDM_SINK=$(( $(pacmd list-sinks | grep "active port" | sed -n '\|hdmi-output|=')-1 ))
    if [ "$HDM_SINK" == -1 ]; then
        HDM=""
    else
        HDM_CMD="%{A4:pavol.sh -i ${HDM_SINK}:}%{A5:pavol.sh -d ${HDM_SINK}:}%{A1:pavol.sh -m ${HDM_SINK}:}"
        if [ "$(pamixer --sink $HDM_SINK --get-mute)" == true ]; then
            HDM_VOL="%{F${PB_MUTE}}--%{F-}"
        else
            HDM_VOL="$(pamixer --sink $HDM_SINK --get-volume)%"
        fi
#        HDM=" ${HDM_CMD}%{F${PB_CRMS}}%{F-} $HDM_VOL%{A}%{A}%{A}"
        HDM=" ${HDM_CMD}%{F${PB_CRMS}}#5%{F-} $HDM_VOL%{A}%{A}%{A}"
    fi
    
    # Bluetooth output
    BLU_SINK=$(( $(pacmd list-sinks | grep "active port" | sed -n '\|speaker-output|=')-1 ))
    if [ "$BLU_SINK" == -1 ]; then
        BLU=""
    else
        BLU_CMD="%{A4:pavol.sh -i ${BLU_SINK}:}%{A5:pavol.sh -d ${BLU_SINK}:}%{A1:pavol.sh -m ${BLU_SINK}:}"
        # Check if mute
        if [ "$(pamixer --sink $BLU_SINK --get-mute)" = true ]; then
            BLU_VOL="%{F${PB_MUTE}}--%{F-}"
        else
            BLU_VOL="$(pamixer --sink $BLU_SINK --get-volume)%"
        fi
#        echo " ${BLU_CMD}%{F${PB_CRMS}}%{F-} $BLU_VOL%{A}%{A}%{A}"
        echo " ${BLU_CMD}%{F${PB_CRMS}}#6%{F-} $BLU_VOL%{A}%{A}%{A}"
    fi

    echo "${ANA}${HDM}${BLU}"
}


volume_print

pactl subscribe | while read -r event; do
if echo "$event" | grep -q -e "#${ANA_SINK}"
then
    volume_print
fi
done
