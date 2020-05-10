#!/bin/bash

################################################################################
###
### AUTHOR & REPO
###
### Johann Birnick
### github: jbirnick
###
### repo: https://github.com/jbirnick/polybar-timer
###
################################################################################
###
### USAGE
###
### Notation: <...> are necessary arguments and [...=DEFAULTVALUE] are optional
### and if you do not specify them their DEFAULTVALUE is used.
###
### You can call this script with the following argument structure:
###
### tail <STANDBY_LABEL> <SECONDS>
###     This is the command which you want to put in your polybar 'exec'-field.
###     It runs an infinite loop calls the 'update' routine every SECONDS seconds.
###     We will call the process which runs this 'tail' routine the tail process.
###
### update <PID>
###     This routine is executed automatically inside the tail process.
###     However, you will most probably want to call it inside the tail process
###     also manually, i.e. in addition to the regular updates, after you have
###     just executed some of the commands below. For example, if you have
###     created a timer with 'new', you want to call 'update' on the tail
###     process right after. PID needs to be the pid of the tail process.
###     (this is provided by polybar with %pid% if you call the 'tail' action
###     inside the exec field of the script module)
###     Therefore, the following action is executed in the tail process
###     regularly and whenever you call 'update' with the pid of the tail process:
###     1. If there is a timer running and its expiry time is <= now then it
###     executes ACTION and kills the timer.
###     2. It prints the current output. This is either
###     "<TIMER_LABEL><minutes left>" if there is a timer running or
###     "<STANDBY_LABEL>" if no timer is running.
###
### These were the basis commands to handle the technical side. Now with the
### following commands you can control the timer. If you want the bar to
### to update immediately after a change, you should call 'update' right after!
### Example: 'polybar.sh inc 60 ; polybar.sh update <pid of tail process>'
### 
### new <MINUTES> <TIMER_LABEL> [ACTION=""]
###     1. If there is a timer already running it gets killed.
###     2. Creates a timer of length MINUTES minutes and TIMER_LABEL as its
###     label and sets its action to ACTION.
###
### inc <SECONDS>
###     If there is no timer running, nothing happens and it exits with 1.
###     If there is a timer running, it is extended by SECONDS seconds. This
###     can also be negative and the the timer gets shortened. Then it exits
###     with 0.
###
### kill
###     If there is a timer running it kills the it. The ACTION will not get
###     executed. (It always exits with 0.)
###
################################################################################
###
### TIPS & TRICKS
###
### When there is no timer active then 'inc' does nothing. The following command
### increases the existing timer if it's active and creates a timer with label
### "mytimer" of lengths 1 minute if there is no timer currently running:
###
### polybar-timer.sh inc 60 || polybar-timer.sh new 1 'mytimer' 'notify-send "Timer expired."'
###
################################################################################
###
### EXAMPLE CONFIGURATION WITH POLYBAR
###
### Please see the github repo linked at the top.
###
################################################################################

## FUNCTIONS

now () { date --utc +%s; }

killTimer () { rm -rf /tmp/polybar-timer ; }
timerRunning () { [ -e /tmp/polybar-timer/ ] ; }

timerExpiry () { cat /tmp/polybar-timer/expiry ; }
timerLabel () { cat /tmp/polybar-timer/label ; }
timerAction () { cat /tmp/polybar-timer/action ; }

secondsLeft () { echo $(( $(timerExpiry) - $(now) )) ; }
minutesLeft () { echo $(( ( $(secondsLeft)  + 59 ) / 60 )) ; }


printExpiryTime () { dunstify -u low -r -12345 "Timer expires at $( date -d "$(secondsLeft) sec" +%H:%M)" ;}

deleteExpiryTime () { dunstify -C -12345 ; }

updateTail () {
  if timerRunning && [ $(minutesLeft) -le 0 ]
  then
    eval $(timerAction)
    killTimer
  fi

  if timerRunning
  then
    echo "$(timerLabel) $(minutesLeft)"
  else
    echo ${STANDBY_LABEL}
  fi
}

## MAIN CODE

case $1 in
  tail)
    STANDBY_LABEL=$2

    trap updateTail USR1

    while true
     do
     updateTail
     sleep ${3} &
     wait
    done
    ;;
  update)
    kill -USR1 $(pgrep --oldest --parent ${2})
    ;;
  new)
    killTimer
    mkdir /tmp/polybar-timer
    echo $(( $(now) + 60*${2} )) > /tmp/polybar-timer/expiry
    echo $3 > /tmp/polybar-timer/label
    echo $4 > /tmp/polybar-timer/action
    printExpiryTime
    ;;
  inc)
    if timerRunning
    then
      echo $(( $(cat /tmp/polybar-timer/expiry) + ${2} )) > /tmp/polybar-timer/expiry
    else
      exit 1
    fi
    printExpiryTime
    ;;
  kill)
    killTimer
    deleteExpiryTime
    ;;
  *)
    echo "Please read the manual inside the file."
    ;;
esac
