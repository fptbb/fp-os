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
    libpcap \
    telnet \
    code \
    hexchat

systemctl enable nordvpnd
systemctl enable tailscaled
