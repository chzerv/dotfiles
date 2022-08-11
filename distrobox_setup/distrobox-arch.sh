#!/usr/bin/env bash

set -o errexit
set -o nounset

# Install packages
CORE_PACKAGES="
    gcc
    gcc-libs
    podman
    git
    base
    base-devel
"

DEV_PACKAGES="
    python3
    python-pip
    python-wheel
    make
    shellcheck
    stylua
"

UTIL_PACKAGES="
    fzf
    ripgrep
    fd
    tmux
    kitty
"

sudo pacman -S --noconfirm ${CORE_PACKAGES} ${DEV_PACKAGES} ${UTIL_PACKAGES}
