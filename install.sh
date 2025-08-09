#!/bin/sh

set -euxo pipefail

DOTFILES_DIR="$HOME/.dotfiles"
LINUX_CONFIG_DIR="$DOTFILES_DIR/linux/config-dir"
LINUX_HOME_DIR="$DOTFILES_DIR/linux/home-dir"

function setup_dotfile() {

    if [ -d "$DOTFILES_DIR" ]; then
        cd "$DOTFILES_DIR" && git switch main && git pull origin main || exit 1
    else
        git clone -b main https://github.com/dipankardas011/dotfiles.git "$DOTFILES_DIR"
    fi
}

function setup_neovim() {
    local NVIM_DIR="$HOME/.config/nvim"
    local LUA_CONFIG="$NVIM_DIR/init.lua"

    if [ ! -d "$NVIM_DIR" ]; then
        mkdir -p "$NVIM_DIR"
    fi

    if [ -f "$LUA_CONFIG" ]; then
        rm -f "$LUA_CONFIG"
    fi

    if [ -L "$LUA_CONFIG" ]; then
        rm -f "$LUA_CONFIG"
    fi

    ln -s "$LINUX_CONFIG_DIR/nvim/init.lua" "$LUA_CONFIG"
}

function setup_tmux() {
    local TMUX_DIR="$HOME/.config/tmux"
    local TMUX_CONF="$TMUX_DIR/tmux.conf"

    if [ ! -d "$TMUX_DIR" ]; then
        mkdir -p "$TMUX_DIR"
    fi

    if [ -f "$TMUX_CONF" ]; then
        rm -f "$TMUX_CONF"
    fi

    if [ -L "$TMUX_CONF" ]; then
        rm -f "$TMUX_CONF"
    fi

    ln -s "$LINUX_CONFIG_DIR/tmux/tmux.conf" "$TMUX_CONF"
}

function setup_alacritty() {
    local ALACRITTY_DIR="$HOME/.config/alacritty"

    if [ ! -d "$ALACRITTY_DIR" ]; then
        mkdir -p "$ALACRITTY_DIR"
    else
        rm -rf "$ALACRITTY_DIR"
    fi


    ln -s "$LINUX_CONFIG_DIR/alacritty" "$ALACRITTY_DIR"
}

function setup_hyprland() {
    local HYPRLAND_DIR="$HOME/.config/hypr"

    if [ ! -d "$HYPRLAND_DIR" ]; then
        mkdir -p "$HYPRLAND_DIR"
    else
        rm -rf "$HYPRLAND_DIR"
    fi

    ln -s "$LINUX_CONFIG_DIR/hypr" "$HYPRLAND_DIR"
}

function setup_waybar() {
    local WAYBAR_DIR="$HOME/.config/waybar"

    if [ ! -d "$WAYBAR_DIR" ]; then
        mkdir -p "$WAYBAR_DIR"
    else
        rm -rf "$WAYBAR_DIR"
    fi

    ln -s "$LINUX_CONFIG_DIR/waybar" "$WAYBAR_DIR"
}

function setup_wofi() {
    local WOFI_DIR="$HOME/.config/wofi"

    if [ ! -d "$WOFI_DIR" ]; then
        mkdir -p "$WOFI_DIR"
    else
        rm -rf "$WOFI_DIR"
    fi

    ln -s "$LINUX_CONFIG_DIR/wofi" "$WOFI_DIR"
}

function setup_zsh() {
    local ZSH_FILE="$HOME/.zshrc"

    if [ ! -f "$ZSH_FILE" ] || [ ! -L "$ZSH_FILE" ]; then
        rm -rf "$ZSH_FILE"
    fi

    ln -s "$LINUX_HOME_DIR/zshrc" "$ZSH_FILE"
}

function setup_wlogout() {
    local WLOGOUT_DIR="$HOME/.config/wlogout"

    if [ ! -d "$WLOGOUT_DIR" ]; then
        mkdir -p "$WLOGOUT_DIR"
    else
        rm -rf "$WLOGOUT_DIR"
    fi

    ln -s "$LINUX_CONFIG_DIR/wlogout" "$WLOGOUT_DIR"
}

function setup_fontconfig() {
    local FONTCONFIG_DIR="$HOME/.config/fontconfig"

    if [ ! -d "$FONTCONFIG_DIR" ]; then
        mkdir -p "$FONTCONFIG_DIR"
    else
        rm -rf "$FONTCONFIG_DIR"
    fi

    ln -s "$LINUX_CONFIG_DIR/fontconfig" "$FONTCONFIG_DIR"

    fc-cache -f -v
    fc-cache --really-force
}

function main() {
    if [ "$(uname)" != "Linux" ]; then
        echo "This script is intended for Linux systems only."
        exit 1
    fi

    setup_dotfile
    setup_neovim
    setup_tmux
    setup_alacritty
    setup_hyprland
    setup_waybar
    setup_wofi
    setup_zsh
    setup_wlogout
    setup_fontconfig
    echo "All configurations have been set up successfully."
}

main "$@"
