#!/bin/bash
set -ouex pipefail

systemctl enable podman.socket
systemctl disable NetworkManager-wait-online.service

# Configure plymouth branding
plymouth-set-default-theme -r
