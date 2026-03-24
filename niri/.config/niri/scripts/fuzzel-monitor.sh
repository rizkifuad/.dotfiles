#!/usr/bin/env bash

SCRIPT="$HOME/.config/niri/scripts/brightness.sh"

# Options with Nerd Font icons
b100="󰃠  100%"
b75="󰃟  75%"
b50="󰃝  50%"
b25="󰃞  25%"
b10="󰃜  10%"
b0="󰃚  0% (Off)"

options="$b0\n$b100\n$b75\n$b50\n$b25\n$b10"

chosen=$(echo -e "$options" | fuzzel --dmenu \
    --prompt "󰃠 Brightness  " \
    --width 30 \
    --lines 6 \
    --border-width 2 \
    --border-radius 10 \
    --horizontal-pad 20 \
    --vertical-pad 12 \
    )

[ -z "$chosen" ] && exit

case "$chosen" in
    *100*) "$SCRIPT" --set 100 ;;
    *75*)  "$SCRIPT" --set 75 ;;
    *50*)  "$SCRIPT" --set 50 ;;
    *25*)  "$SCRIPT" --set 25 ;;
    *10*)  "$SCRIPT" --set 10 ;;
    *0*)   "$SCRIPT" --set 0 ;;
esac
