#!/bin/bash

# Function to get current volume mute status
get_volume_mute_status() {
    pactl get-sink-mute @DEFAULT_SINK@ | awk '{print $2}'
}

# Function to show volume status notification
show_volume_notification() {
    local status=$(get_volume_mute_status)
    local icon
    local message

    if [ "$status" == "yes" ]; then
        icon="🔇"
        message="Muted"
    else
        icon="🔊"
        message="Unmuted"
    fi

    notify-send "Volume ${icon}" \
        "<b>Status: ${message}</b>" \
        -h string:x-dunst-stack-tag:volume \
        -h string:status:"$message" \
        -t 1000
}

# Function to get current microphone mute status
get_mic_mute_status() {
    pactl get-source-mute @DEFAULT_SOURCE@ | awk '{print $2}'
}

# Function to show microphone status notification
show_mic_notification() {
    local status=$(get_mic_mute_status)
    local icon
    local message

    if [ "$status" == "yes" ]; then
        icon="🔇"
        message="Muted"
    else
        icon="🎤"
        message="Unmuted"
    fi

    notify-send "Microphone ${icon}" \
        "<b>Status: ${message}</b>" \
        -h string:x-dunst-stack-tag:microphone \
        -h string:status:"$message" \
        -t 1000
}

# Main logic
case "$1" in
    volume)
        pactl set-sink-mute @DEFAULT_SINK@ toggle
        refresh_i3status
        show_volume_notification
        ;;
    mic|microphone)
        pactl set-source-mute @DEFAULT_SOURCE@ toggle
        refresh_i3status
        show_mic_notification
        ;;
    *)
        echo "Usage: $0 [volume|mic]"
        exit 1
        ;;
esac
