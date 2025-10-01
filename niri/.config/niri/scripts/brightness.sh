#!/usr/bin/env bash

iDIR="$HOME/.config/mako/icons"
MONITOR="1"   # change if you have multiple monitors (use: ddcutil detect)
icon="$iDIR/brightness-icon.png"

CACHE_FILE="/tmp/current_backlight_value"

# Get brightness (with cache)
get_backlight() {
    if [[ -s "$CACHE_FILE" ]]; then
        LIGHT=$(cat "$CACHE_FILE")
    else
        LIGHT=$(ddcutil getvcp --noverify --skip-ddc-checks --display $MONITOR 10 | grep "current value =" | awk '{print $9}' | tr -d ',')
        echo "$LIGHT" > "$CACHE_FILE"
    fi
    echo "$LIGHT"
}

set_backlight() {
    local value="$1"
    ddcutil setvcp --noverify --skip-ddc-checks  --display $MONITOR 10 "$value" >/dev/null 2>&1
    echo "$value" > "$CACHE_FILE"
}

# Notify
notify_user() {
    notify-send -h string:x-canonical-private-synchronous:sys-notify \
        -u low -i "$icon" "Brightness : $(get_backlight)%"
}

# Increase brightness
inc_backlight() {
    current=$(get_backlight)
    new=$((current + 10))
    if [[ $new -gt 100 ]]; then new=100; fi
    set_backlight "$new"
    notify_user
}

# Decrease brightness
dec_backlight() {
    current=$(get_backlight)
    new=$((current - 10))
    if [[ $new -lt 0 ]]; then new=0; fi
    set_backlight "$new"
    notify_user
}

# Execute accordingly
case "$1" in
    --get) get_backlight ;;
    --inc) inc_backlight ;;
    --dec) dec_backlight ;;
    --set) set_backlight "$2" ;;
    *)     get_backlight ;;
esac
