#!/bin/bash
set -ouex pipefail

RELEASE="$(rpm -E %fedora)"

enable_copr() {
    repo="$1"
    repo_with_dash="${repo/\//-}"
    wget "https://copr.fedorainfracloud.org/coprs/${repo}/repo/fedora-${RELEASE}/${repo_with_dash}-fedora-${RELEASE}.repo" \
        -O "/etc/yum.repos.d/_copr_${repo_with_dash}.repo"
}

### Add NordVPN repo
rpm --import https://repo.nordvpn.com/gpg/nordvpn_public.asc

dnf5 config-manager addrepo --id="nordvpn" \
    --set=baseurl="https://repo.nordvpn.com/yum/nordvpn/centos/$(uname -m)" \
    --set=enabled=1 \
    --overwrite

### Add Tailscale repo
dnf5 config-manager addrepo --from-repofile=https://pkgs.tailscale.com/stable/fedora/tailscale.repo --overwrite

### Add Microsoft VS Code repo
# Import Microsoft GPG key
rpm --import https://packages.microsoft.com/keys/microsoft.asc

# Add VS Code repository using dnf5 config-manager for better readability
dnf5 config-manager addrepo --id="code" \
    --set=name="Visual Studio Code" \
    --set=baseurl="https://packages.microsoft.com/yumrepos/vscode" \
    --set=enabled=1 \
    --set=gpgcheck=1 \
    --set=gpgkey="https://packages.microsoft.com/keys/microsoft.asc" \
    --set=type="rpm-md" \
    --overwrite

### Add COPR repos
# enable_copr some/coprrepo
enable_copr bigjapka/VeraCrypt
