#!/bin/sh

icon_intel="#1"
icon_nvidia="#2"
icon_hybrid="#3"

hybrid_switching=0

gpu_current() {
	mode=$(envycontrol --query)

    echo "$mode" 
}

gpu_switch() {
    mode=$(gpu_current)

	if [ "$mode" = "intel" ]; then
		next="nvidia"
	elif [ "$mode" = "nvidia" ]; then
		if [ "$hybrid_switching" = 1 ]; then
			next="hybrid"
		else
			next="intel"
		fi
	elif [ "$mode" = "hybrid" ]; then
		next="nvidia"
	fi

	envycontrol --switch "$next" 
}

gpu_display(){
    mode=$(gpu_current)

    if [ "$mode" = "intel" ]; then
		echo "$icon_intel"
	elif [ "$mode" = "nvidia" ]; then
		echo "$icon_nvidia"
	elif [ "$mode" = "hybrid" ]; then
		echo "$icon_hybrid"
	fi
}

case "$1" in
	--switch)
        gpu_switch
        ;;
    *)
        gpu_display
        ;;
esac
