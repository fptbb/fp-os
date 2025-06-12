#!/bin/bash
set -ouex pipefail

# Get Bazzite's pinned kernel version, export it for build
export KERNEL_VERSION=$(curl -fsSL \
        https://raw.githubusercontent.com/ublue-os/bazzite/refs/heads/main/.github/workflows/build.yml | \
        grep -m1 'kernel_version:' | \
        awk '{gsub(/#.*/,""); print $2}' | \
        xargs)
export KERNEL_FLAVOR="bazzite"

# Update initramfs
KERNEL_SUFFIX=""

QUALIFIED_KERNEL="$(dnf5 repoquery --installed --queryformat='%{evr}.%{arch}' "kernel${KERNEL_SUFFIX:+-${KERNEL_SUFFIX}}")"
/usr/bin/dracut --no-hostonly --kver "$QUALIFIED_KERNEL" --reproducible --zstd -v --add ostree -f "/usr/lib/modules/$QUALIFIED_KERNEL/initramfs.img"

chmod 0600 /usr/lib/modules/"$QUALIFIED_KERNEL"/initramfs.img

# Set up services
systemctl enable podman.socket
systemctl disable NetworkManager-wait-online.service
