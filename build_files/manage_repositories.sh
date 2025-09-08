#!/bin/bash
set -ouex pipefail

RELEASE="$(rpm -E %fedora)"

enable_copr() {
    repo="$1"
    repo_with_dash="${repo/\//-}"
    dnf5 config-manager addrepo \
        --from-repofile="https://copr.fedorainfracloud.org/coprs/${repo}/repo/fedora-${RELEASE}/${repo_with_dash}-fedora-${RELEASE}.repo" \
        --overwrite
}

enable_opensuse_bs() {
    repo="$1" # format: where:namespace:project
    dnf5 config-manager addrepo \
        --from-repofile="https://download.opensuse.org/repositories/${repo}/Fedora_${RELEASE}/${repo}.repo" \
        --overwrite
}

### Add NordVPN repo
dnf5 config-manager addrepo --id="nordvpn" \
    --set=baseurl="https://repo.nordvpn.com/yum/nordvpn/centos/$(uname -m)" \
    --set=enabled=1 \
    --set=gpgkey="https://repo.nordvpn.com/gpg/nordvpn_public.asc" \
    --set=gpgcheck=1 \
    --overwrite

### Add Tailscale repo
dnf5 config-manager addrepo --from-repofile=https://pkgs.tailscale.com/stable/fedora/tailscale.repo --overwrite

### Add Netbird, alternative to Tailscale
tee /etc/yum.repos.d/netbird.repo <<'EOF'
[NetBird]
name=NetBird
baseurl=https://pkgs.netbird.io/yum/
enabled=1
gpgcheck=0
gpgkey=https://pkgs.netbird.io/yum/repodata/repomd.xml.key
repo_gpgcheck=1
EOF

### Add COPR repos
# enable_copr some/coprrepo
enable_copr bigjapka/VeraCrypt
enable_copr psygreg/linuxtoys
enable_copr zeno/scrcpy

### Add OpenSUSE Build Service repos
# enable_opensuse_bs where:some:repo
enable_opensuse_bs home:TheLocehiliosan:yadm
