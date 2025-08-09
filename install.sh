#!/bin/sh

set -euxo pipefail

DOTFILES_DIR="$HOME/.dotfiles"


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


    if [ -L "$LUA_CONFIG" ]; then
        rm -f "$LUA_CONFIG"
    fi

    ln -s "$DOTFILES_DIR/linux/config-dir/nvim/init.lua" "$LUA_CONFIG"
}



function main() {
    if [ "$(uname)" = "Linux" ]; then
        setup_dotfile
        echo "Dotfiles setup completed successfully."
    else
        echo "This script is intended for Linux systems only."
        exit 1
    fi

    setup_dotfile
    setup_neovim
}

main "$@"
