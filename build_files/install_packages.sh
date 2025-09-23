#!/bin/bash
set -ouex pipefail

# this installs my meta package from fptbb/fp-os-meta copr
dnf5 install -y fp-os-meta

# this installs packages related to coprs and suse's obs.
dnf5 install -y \
  yadm \
  veracrypt \
  nordvpn \
  tailscale \
  netbird \
  netbird-ui \
  linuxtoys \
  scrcpy \
  megasync \
  dolphin-megasync \
  megacmd

systemctl enable nordvpnd
systemctl enable tailscaled
systemctl enable netbird
