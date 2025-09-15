#!/bin/bash
set -ouex pipefail

# this installs a package from fedora repos
dnf5 install -y \
    pam-u2f \
    yadm \
    kleopatra \
    veracrypt \
    nordvpn \
    tailscale \
    netbird \
    netbird-ui \
    gnome-disk-utility \
    gnome-calculator \
    kde-partitionmanager \
    tmux \
    kitty \
    zsh \
    powerline-fonts \
    bash-completion \
    code \
    buildah \
    git \
    gnupg2 \
    golang \
    tinygo \
    upx \
    dialog \
    freerdp \
    iproute \
    libnotify \
    libpcap \
    netcat \
    nmap-ncat \
    freerdp \
    gameconqueror \
    coreos-installer \
    linuxtoys \
    scrcpy \
    android-tools \
    pmbootstrap \
    yt-dlp \
    fuse-encfs \
    megatools


systemctl enable nordvpnd
systemctl enable tailscaled
systemctl enable netbird
