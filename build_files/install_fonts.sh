#!/bin/bash
set -ouex pipefail

FONT_DIR="/usr/share/fonts/nerdfonts"
mkdir -p "$FONT_DIR"

install_nerd_font() {
    local font_name="$1"
    local font_url="https://github.com/ryanoasis/nerd-fonts/releases/download/v3.1.1/${font_name}.zip"

    echo "Installing Nerd Font: $font_name"
    cd "$FONT_DIR"
    curl -fLo "${font_name}.zip" "$font_url"
    unzip -o "${font_name}.zip" -d "${font_name}"
    rm -f "${font_name}.zip"
}

# Install desired fonts
install_nerd_font "FiraCode"
install_nerd_font "FiraMono"

# Update font cache
fc-cache -fv
