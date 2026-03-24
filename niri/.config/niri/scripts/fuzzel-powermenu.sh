#!/usr/bin/env bash

# Icons (Nerd Font required)
shutdown="  Shutdown"
reboot="  Reboot"
lock="  Lock"
suspend=" Suspend"
logout=" Logout"

options="$shutdown\n$reboot\n$lock\n$suspend\n$logout"

chosen=$(echo -e "$options" | fuzzel --dmenu \
    --prompt "⏻ Power Menu  " \
    --width 30 \
    --lines 5 \
    --border-width 2 \
    --border-radius 10 \
    --horizontal-pad 20 \
    --vertical-pad 12 \
    )

[ -z "$chosen" ] && exit

# Confirmation menu
confirm=$(echo -e "  Cancel\n  Confirm" | fuzzel --dmenu \
    --prompt "⚠ Confirm  " \
    --width 20 \
    --lines 2 \
    --border-radius 10 \
    )

[[ "$confirm" != *Confirm ]] && exit

case "$chosen" in
    *Shutdown)
        systemctl poweroff
        ;;
    *Reboot)
        systemctl reboot
        ;;
    *Suspend)
        systemctl suspend
        ;;
    *Lock)
        swaylock || hyprlock || loginctl lock-session
        ;;
    *Logout)
        if [ -n "$SWAYSOCK" ]; then
            swaymsg exit
        elif [ -n "$HYPRLAND_INSTANCE_SIGNATURE" ]; then
            hyprctl dispatch exit
        else
            loginctl terminate-session "$XDG_SESSION_ID"
        fi
        ;;
esac
