#!/bin/sh
# polybar Dropbox module by github.com/ylwghst
# Feel free to use, share or change it without any restrictions

# These can be changed to hex codes of your favourite colours
colorRunning="#dfdfdf"
colorStopped="#555"

pid=`pgrep -x "dropbox"`

function isRunning {
  if pgrep -x "dropbox" > /dev/null; then
    return 0
  fi
    return 1
}

if [[ $# -gt 0 ]]; then
  case "$1" in
      toggle)
          if isRunning; then
              kill $pid; exit 0
          fi
          (dropbox &);
          ;;
          *)
              echo 'error: wrong argument'; exit 1
          ;;
  esac
fi

if isRunning; then
    echo "%{F$colorRunning}%{F-}"; exit 0
fi
echo "%{F$colorStopped}%{F-}"
exit 0
