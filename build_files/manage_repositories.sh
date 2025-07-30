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

### Add Yadm repo from OpenSUSE infra
dnf5 config-manager addrepo --from-repofile="https://download.opensuse.org/repositories/home:TheLocehiliosan:yadm/Fedora_${RELEASE}/home:TheLocehiliosan:yadm.repo" --overwrite

### Add COPR repos
# enable_copr some/coprrepo
enable_copr bigjapka/VeraCrypt
