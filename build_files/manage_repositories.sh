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
    repo="$1" # format: namespace/project
    repo_with_colon="${repo/\//:}" # OBS uses colons in the URL instead of slashes
    dnf5 config-manager addrepo \
        --from-repofile="https://download.opensuse.org/repositories/home:${repo_with_colon}/Fedora_${RELEASE}/home:${repo_with_colon}.repo" \
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

### Add OpenSUSE Build Service repos
# enable_opensuse_bs some/repo
enable_opensuse_bs TheLocehiliosan/yadm
