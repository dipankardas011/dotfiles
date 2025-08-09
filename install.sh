#!/bin/sh

set -euxo pipefail

DOTFILES_DIR="$HOME/.dotfiles"
LINUX_CONFIG_DIR="$DOTFILES_DIR/linux/config-dir"

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

function main() {
    if [ "$(uname)" != "Linux" ]; then
        echo "This script is intended for Linux systems only."
        exit 1
    fi

    setup_dotfile
    setup_neovim
    setup_tmux
}

main "$@"
