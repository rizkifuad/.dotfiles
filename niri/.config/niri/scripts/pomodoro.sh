#!/bin/bash

# Time definitions (in seconds)
POMODORO=1500  # 25 minutes of focus
SHORT_BREAK=300  # 5-minute break
LONG_BREAK=900  # 15-minute break after 4 cycles

CYCLES=0

while true; do
    ((CYCLES++))

    # 🎯 Focus Time
    notify-send "🔴 Pomodoro started!" "Focus for 25 minutes." -u critical
    sleep $POMODORO

    # If 4 cycles are completed, take a long break
    if ((CYCLES % 4 == 0)); then
        notify-send "🌿 Long Break!" "Rest for 15 minutes." -u critical
        sleep $LONG_BREAK
        #paplay /usr/share/sounds/freedesktop/stereo/complete.oga
        #zenity --info --title="Pomodoro" --text="🏁 Long break over! Get back to work." --width=300 --height=100
    else
        # 🚀 Short Break
        notify-send "☕ Short Break!" "Relax for 5 minutes." -u critical 
        sleep $SHORT_BREAK
        #paplay /usr/share/sounds/freedesktop/stereo/complete.oga
        #zenity --info --title="Pomodoro" --text="🎯 Short break over! Get ready for the next cycle." --width=300 --height=100
    fi
done
