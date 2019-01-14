#!/bin/bash

# fork from Per-core temperatures :
# https://github.com/jaagr/polybar/wiki/User-contributed-modules#per-core-temperatures

# Get information from cores temp thanks to sensors
rawData=$( sensors | grep -m 1 Core | awk '{print substr($3, 2, length($3)-5)}' )
tempCore=($rawData)

# Define constants :
degree="°C"
temperaturesValues=(40 50 60 70 80 90)
temperaturesColors=("#6bff49" "#f4cb24" "#ff8819" "#ff3205" "#f40202" "#ef02db")
temperaturesIcons=(     )

for iCore in ${!tempCore[*]}
do
    for iTemp in ${!temperaturesValues[*]}
    do
        if (( "${tempCore[$iCore]}" < "${temperaturesValues[$iTemp]}"  )); then
            tmpEcho="%{F${temperaturesColors[$iTemp]}}${tempCore[$iCore]}$degree%{F-}"
            finalEcho="$finalEcho $tmpEcho"
            break
        fi
    done
    total=$(( ${tempCore[$iCore]} + total ));
done

sum=$(( $total/${#tempCore[*]} ))

for iTemp in ${!temperaturesValues[*]}
do
    if (( "$sum" < "${temperaturesValues[$iTemp]}" )); then
        ## This line will color the icon too
        tmpEcho="%{F${temperaturesColors[$iTemp]}}${temperaturesIcons[$iTemp]}%{F-}"
        ## This line will NOT color the icon
        #tmpEcho="${temperaturesIcons[$iTemp]}"
        finalEcho=" $tmpEcho $finalEcho"
        break
    fi
done

echo $finalEcho
