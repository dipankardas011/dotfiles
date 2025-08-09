#!/bin/bash

while true; do
    battery_level=$(cat /sys/class/power_supply/BAT0/capacity)
    battery_status=$(cat /sys/class/power_supply/BAT0/status)

    if [ "$battery_status" = "Discharging" ]; then
        if [ "$battery_level" -le 10 ]; then
            notify-send -u critical \
                -i battery-empty \
                "Critical Battery Level" \
                "Battery level is ${battery_level}%!\nSystem will hibernate soon" \
                -h string:x-dunst-stack-tag:battery
        elif [ "$battery_level" -le 20 ]; then
            notify-send -u critical \
                -i battery-caution \
                "Low Battery Warning" \
                "Battery level is ${battery_level}%\nPlease connect charger" \
                -h string:x-dunst-stack-tag:battery
        fi
    fi

    sleep 60
done

