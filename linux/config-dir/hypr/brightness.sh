#!/bin/bash

# Amount to increase or decrease brightness by (percentage)
STEP=5

# Function to get current brightness as integer
get_brightness() {
    printf "%.0f" "$(light -G)"
}

# Function to show brightness notification
show_brightness_notification() {
    local brightness=$(get_brightness)
    local icon="󰃠"

    if [ "$brightness" -lt 20 ]; then
        icon="󰃞"
    elif [ "$brightness" -lt 40 ]; then
        icon="󰃟"
    fi

    notify-send "${icon}  Brightness · ${brightness}%" \
        -h string:x-dunst-stack-tag:brightness \
        -h int:value:"${brightness}" \
        -t 1000
}

# Main logic
case "$1" in
up)
    light -A $STEP
    show_brightness_notification
    ;;
down)
    light -U $STEP
    show_brightness_notification
    ;;
*)
    echo "Usage: $0 [up|down]"
    exit 1
    ;;
esac
