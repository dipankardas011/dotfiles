#!/usr/bin/env bash

set -euo pipefail

DOTFILES_DIR="$HOME/.dotfiles"
LINUX_CONFIG_DIR="$DOTFILES_DIR/linux/config-dir"
LINUX_HOME_DIR="$DOTFILES_DIR/linux/home-dir"
LINUX_DIR="$DOTFILES_DIR/linux"

log() {
    printf '\n==> %s\n' "$*"
}

remove_path() {
    local path="$1"

    if [ -e "$path" ] || [ -L "$path" ]; then
        rm -rf "$path"
    fi
}

link_path() {
    local source="$1"
    local target="$2"

    if [ ! -e "$source" ]; then
        printf 'Missing source: %s\n' "$source" >&2
        exit 1
    fi

    mkdir -p "$(dirname "$target")"
    remove_path "$target"
    ln -s "$source" "$target"
}

link_config_dir() {
    local name="$1"

    link_path "$LINUX_CONFIG_DIR/$name" "$HOME/.config/$name"
}

setup_dotfile() {
    log "Setting up dotfiles repository"

    if [ -d "$DOTFILES_DIR/.git" ]; then
        git -C "$DOTFILES_DIR" switch main
        git -C "$DOTFILES_DIR" pull origin main
    elif [ -d "$DOTFILES_DIR" ]; then
        printf '%s exists but is not a git repository. Please inspect it manually.\n' "$DOTFILES_DIR" >&2
        exit 1
    else
        git clone -b main https://github.com/dipankardas011/dotfiles.git "$DOTFILES_DIR"
    fi
}

setup_neovim() {
    log "Setting up Neovim"

    # Link the whole Neovim config directory because the config is modular:
    # init.lua + lua/config, lua/packages, lua/plugins, etc.
    link_config_dir "nvim"
}

setup_tmux() {
    log "Setting up tmux"

    link_config_dir "tmux"
}

setup_alacritty() {
    log "Setting up Alacritty"

    link_config_dir "alacritty"
}

setup_hyprland() {
    log "Setting up Hyprland"

    link_config_dir "hypr"
}

setup_waybar() {
    log "Setting up Waybar"

    link_config_dir "waybar"
}

setup_wofi() {
    log "Setting up Wofi"

    link_config_dir "wofi"
}

setup_bash() {
    log "Setting up bash"

    link_path "$LINUX_CONFIG_DIR/bashrc" "$HOME/.bashrc"
}

setup_wlogout() {
    log "Setting up wlogout"

    link_config_dir "wlogout"
}

setup_fontconfig() {
    log "Setting up fontconfig"

    link_config_dir "fontconfig"
    fc-cache -f -v
    fc-cache --really-force
}

set_wayland_overrides_application() {
    log "Installing Wayland desktop overrides"

    local desktop_file
    for desktop_file in discord.desktop slack.desktop 1password.desktop; do
        sudo cp -v "$LINUX_DIR/$desktop_file" /usr/share/applications/
    done
}

main() {
    if [ "$(uname)" != "Linux" ]; then
        printf 'This script is intended for Linux systems only.\n' >&2
        exit 1
    fi

    setup_dotfile
    setup_neovim
    setup_tmux
    setup_alacritty
    setup_hyprland
    setup_waybar
    setup_wofi
    setup_bash
    setup_wlogout
    setup_fontconfig
    set_wayland_overrides_application

    log "All configurations have been set up successfully"
    printf 'Please restart your terminal or source your shell configuration to apply changes.\n'
    printf 'Please check out https://github.com/pyenv/pyenv and https://github.com/nvm-sh/nvm\n'
}

main "$@"
