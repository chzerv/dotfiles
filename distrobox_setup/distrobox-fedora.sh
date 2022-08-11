#!/usr/bin/env bash

set -o errexit
set -o nounset

# Append text to a file, only if the text does not already exist
# arg1: text to append
# arg2: file to append the text to
function append_to_file() {
    text="${1}"
    file="${2}"

    if ! grep -q "${text}" "${file}" 2> /dev/null; then
        echo "${text}" | sudo tee -a "${file}"
    fi
}

# Make dnf faster
DNF_TWEAKS="
  deltarpm=True
  fastestmirror=True
  max_parallel_downloads=10
"

for setting in ${DNF_TWEAKS}; do
    append_to_file "${setting}" /etc/dnf/dnf.conf
done

# Enable RPMFusion
sudo dnf install -y \
    https://mirrors.rpmfusion.org/free/fedora/rpmfusion-free-release-$(rpm -E %fedora).noarch.rpm \
    https://mirrors.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-$(rpm -E %fedora).noarch.rpm

# Enable  neovim-nightly COPR
sudo dnf copr enable -y agriffis/neovim-nightly

# Install packages
DEV_PACKAGES="
    python3
    python3-pip
    python3-wheel
    neovim
    make
    gcc
    gcc-c++
    ShellCheck
"

UTIL_PACKAGES="
    fzf
    vgrep
    ripgrep
    fd-find
"

sudo dnf install -y ${DEV_PACKAGES} ${UTIL_PACKAGES}
