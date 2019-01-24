#!/usr/bin/env sh

x=25
y=25

updates_arch=`checkupdates 2> /dev/null`
updates_aur=`checkupdates-aur 2> /dev/null`
n_updates_arch=`echo "$updates_arch" | sed '/^$/d' | wc -l`
n_updates_aur=`echo "$updates_aur" | sed '/^$/d' | wc -l`

n_updates=$(("$n_updates_arch" + "$n_updates_aur"))

case "$1" in
    --updates)
	if [ $n_updates == 0 ]; then
		yad --text "System is up to date" --fixed --close-on-unfocus --no-buttons \
			--posx=$x --posy=$y > /dev/null
	else
		yad --text "$(printf "Base: \n%s\n\nAUR: \n%s" "$updates_arch" "$updates_aur")" \
		       	--fixed --close-on-unfocus --no-buttons --posx=$x --posy=$y  \
			> /dev/null
	fi
	;;
    *)  
	if [ "$n_updates" == 0 ]; then
    	    echo " "
	else
    	    echo " $n_updates"
	fi
	;;
esac
