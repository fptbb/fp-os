#!/bin/bash
set -ouex pipefail

# this installs a package from fedora repos
dnf5 install -y \
    tmux \
    kleopatra \
    gnome-disk-utility \
    kitty \
    zsh \
    gnome-calculator \
    powerline-fonts \
    veracrypt \
    nordvpn \
    tailscale \
    bash-completion \
    code \
    buildah \
    yadm \
    git \
    gnupg2 \
    dialog \
    freerdp \
    iproute \
    libnotify \
    kde-partitionmanager \
    coreos-installer \
    netcat \
    nmap-ncat \
    freerdp \
    golang \
    tinygo \
    upx \
    cloudflare-warp

systemctl enable nordvpnd
systemctl enable tailscaled
