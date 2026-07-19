#!/usr/bin/env bash
# CPU temperature (k10temp Tctl) with dynamic color class + icon for waybar
raw=$(cat /sys/class/hwmon/hwmon8/temp1_input)
t=$((raw / 1000))

if   [ "$t" -ge 78 ]; then class="hot";    icon=""
elif [ "$t" -ge 65 ]; then class="warm";   icon=""
elif [ "$t" -ge 50 ]; then class="normal"; icon=""
else                       class="cool";   icon=""
fi

printf '{"text":"%s %s°C","class":"%s","tooltip":"CPU Tctl: %s°C"}\n' "$icon" "$t" "$class" "$t"
