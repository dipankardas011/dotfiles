#!/bin/bash

rofi -show clipboard \
  -modi "clipboard:$HOME/.config/hypr/cliphist-rofi-img" \
  -display-clipboard "Clipboard" \
  -show-icons \
  -theme "$HOME/.config/rofi/cliphist.rasi"
