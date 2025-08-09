#!/bin/bash

currBat=$(cat /sys/class/power_supply/BAT0/capacity)

stats=$(cat /sys/class/power_supply/BAT0/status)

tt=$(date +'%H:%M %d-%m-%y')

echo "--------"
if [[ $currBat -lt 80 && $stats = 'Discharging' ]]; then
    # normal mode
    echo "${tt} start charging ${currBat}"
    sudo sed -i s/STOP_CHARGE_THRESH_BAT0=1/STOP_CHARGE_THRESH_BAT0=0/g /etc/tlp.conf
    sudo tlp start
elif [[ $currBat -lt 80 && $stats = 'Not charging' ]]; then
    # normal mode
    echo "${tt} start charging ${currBat}"
    sudo sed -i s/STOP_CHARGE_THRESH_BAT0=1/STOP_CHARGE_THRESH_BAT0=0/g /etc/tlp.conf
    sudo tlp start
elif [[ $currBat -ge 85 && $stats = 'Charging' ]]; then
    # conservative mode
    echo "${tt} stop charging ${currBat}"
    sudo sed -i s/STOP_CHARGE_THRESH_BAT0=0/STOP_CHARGE_THRESH_BAT0=1/g /etc/tlp.conf
    sudo tlp start
else
    echo "${tt} No action needed ${currBat}"
fi

echo "--------"
