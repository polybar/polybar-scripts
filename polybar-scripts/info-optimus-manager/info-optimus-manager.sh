#!/bin/sh

# Simple script for displaying and switching gpus for optimus-manager and polybar.


# Configuration

# Set the symbols to be displayed in polybar
intel_symbol="GPU: Intel"
nvidia_symbol="GPU: Nvidia"
hybrid_symbol="GPU: Hybrid"

# Prefered setup. 
# Set to 1 if the system switches between hybrid and nvidia.
# Set to 0 if the system switches between intel and nvidia.
hybrid_switching=0



# Functions

get_current(){
	mode=$(optimus-manager --print-mode)
	
	if [[ $mode == *"intel"* ]]; then
		echo "intel"
	elif [[ $mode == *"nvidia"* ]]; then
		echo "nvidia"
	elif [[ $mode == *"hybrid"* ]]; then
		echo "hybrid"
	fi
}

display_gpu(){
	if [[ $(get_current) == "intel" ]]; then
		echo "$intel_symbol"
	elif [[ $(get_current) == "nvidia" ]]; then
		echo "$nvidia_symbol"
	elif [[ $(get_current) == "hybrid" ]]; then
		echo "$hybrid_symbol"
	fi
}

switch_gpu(){	
	if [[ $(get_current) == "intel" ]]; then
		next="nvidia"
	elif [[ $(get_current) == "nvidia" ]]; then
		if [[ $hybrid_switching == 1 ]]; then
			next="hybrid"
		else
			next="intel"
		fi
	elif [[ $(get_current) == "hybrid" ]]; then
		next="nvidia"
	fi	
	eval "optimus-manager --switch $next --no-confirm"
}

# Handle arguments. 

case "$1" in
	--switch)
	switch_gpu
	;;
*)
	display_gpu
	;;
esac


	
