#!/bin/sh

icon_intel="Intel"
icon_nvidia="Nvidia"
icon_hybrid="Hybrid"

hybrid_switching=1

gpu_current() {
  mode=$(optimus-manager --print-mode)
  echo "$mode" | cut -d ' ' -f 5 | tr -d '[:space:]'
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

  optimus-manager --switch $next --no-confirm
}

gpu_display(){
  mode=$(gpu_current)

  if [ "$mode" = "intel" ]; then
    echo "$icon_intel"
  elif [ "$mode" = "nvidia" ]; then
    echo "$icon_nvidia"
  elif [ "$mode" = "hybrid" ]; then
    echo "$icon_hybrid"
  else
    echo "Unknown"
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
