#!/bin/bash
set -ouex pipefail

systemctl enable podman.socket
systemctl disable NetworkManager-wait-online.service

# Configure plymouth branding
mkdir -p /var/tmp
chmod -R 1777 /var/tmp
plymouth-set-default-theme -r
dracut --force --regenerate-all --verbose --tmpdir /var/tmp
