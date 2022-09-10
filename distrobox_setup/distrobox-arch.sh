#!/usr/bin/env bash

set -o errexit
set -o nounset

# Packages to install
PACKAGES="
    gcc
    gcc-libs
    podman
    git
    base
    base-devel
    python3
    python-pip
    python-wheel
    make
    shellcheck
    stylua
    fzf
    ripgrep
    fd
    tmux
    kitty
    obsidian
    syncthing
    bitwarden
"

# shellcheck disable=SC2086
sudo pacman -S --noconfirm ${PACKAGES}

distrobox-export --app obsidian -ef "--ozone-platform=wayland"
distrobox-export --app brave -ef "--ozone-platform=wayland"
distrobox-export --app "bitwarden-desktop" -ef "--ozone-platform=wayland"
distrobox-export --bin "$(which syncthing)" -ep ~/.local/bin
distrobox-export --bin "$(which stylua)" -ep ~/.local/bin
