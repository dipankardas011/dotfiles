#!/bin/bash

# Constants
MAX_VOLUME=100
STEP_SIZE=10
MAX_VOLUME_UPPER=90  # Upper limit before requiring special handling

# Function to get current volume
get_current_volume() {
    pactl get-sink-volume "$(pactl get-default-sink)" | 
        sed -e 's,.* \([0-9][0-9]*\)%.*,\1,' | 
        head -n1
}

# Function to show volume notification with dunst formatting
show_volume_notification() {
    local volume=$(get_current_volume)
    local icon
    
    # Select icon based on volume level
    if [ "$volume" -eq 0 ]; then
        icon="🔇"
    elif [ "$volume" -lt 30 ]; then
        icon="🔈"
    elif [ "$volume" -lt 70 ]; then
        icon="🔉"
    else
        icon="🔊"
    fi
    
    # Send notification with dunst formatting
    notify-send "Volume ${icon}" \
        "<b>Level: ${volume}%</b>" \
        -h string:x-dunst-stack-tag:volume \
        -h int:value:"$volume" \
        -t 1000
}

# Function to adjust volume
adjust_volume() {
    local operation=$1
    local current_volume=$(get_current_volume)
    
    case $operation in
        "UP")
            if [ "$current_volume" -le $MAX_VOLUME_UPPER ]; then
                pactl set-sink-volume @DEFAULT_SINK@ "+${STEP_SIZE}%"
            else
                local diff=$(( MAX_VOLUME - current_volume ))
                if [ "$diff" -gt 0 ]; then
                    pactl set-sink-volume @DEFAULT_SINK@ "+${diff}%"
                fi
            fi
            ;;
        "DOWN")
            pactl set-sink-volume @DEFAULT_SINK@ "-${STEP_SIZE}%"
            ;;
        *)
            notify-send "Volume Error ⚠️" \
                "<b>Invalid operation:</b> $operation" \
                -h string:x-dunst-stack-tag:volume_error \
                -u critical \
                -t 2000
            exit 1
            ;;
    esac
    
    show_volume_notification
    [ -n "$refresh_i3status" ] && $refresh_i3status
}

# Main execution
if [ -z "$1" ]; then
    notify-send "Volume Error ⚠️" \
        "<b>No operation specified</b>\nUse: UP or DOWN" \
        -h string:x-dunst-stack-tag:volume_error \
        -u critical \
        -t 2000
    exit 1
fi

adjust_volume "$1"
