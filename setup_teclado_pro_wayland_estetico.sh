#!/bin/bash

set -e

echo "🔥 Configurando Ubuntu Wayland PRO (100% Wayland Friendly) 🔥"

sudo apt update && sudo apt upgrade -y

sudo apt install -y wofi gnome-shell-extensions gnome-shell-extension-manager \
                    fonts-jetbrains-mono fonts-firacode gnome-tweaks curl unzip

gsettings set org.gnome.desktop.interface font-name 'JetBrains Mono 11'
gsettings set org.gnome.desktop.interface document-font-name 'JetBrains Mono 11'
gsettings set org.gnome.desktop.interface monospace-font-name 'JetBrains Mono 11'

gsettings set org.gnome.desktop.interface gtk-theme 'Yaru-dark'
gsettings set org.gnome.desktop.interface icon-theme 'Yaru'
gsettings set org.gnome.desktop.interface cursor-theme 'Yaru'
gsettings set org.gnome.desktop.interface color-scheme 'prefer-dark'

WALLPAPER_DIR="$HOME/Pictures/Wallpapers"
mkdir -p "$WALLPAPER_DIR"
cp ./assets/wallpaper.png "$WALLPAPER_DIR/wayland_pro_wallpaper.png"
gsettings set org.gnome.desktop.background picture-uri "file://$WALLPAPER_DIR/wayland_pro_wallpaper.png"
gsettings set org.gnome.desktop.background picture-options 'zoom'

curl -sS https://starship.rs/install.sh | sh -s -- -y

mkdir -p "$HOME/.config"
cat > "$HOME/.config/starship.toml" << CONFIG
format = "\$username@\${hostname} \$directory \$git_branch\$git_status \$character"

[username]
style_user = "bold green"
style_root = "bold red"
format = "[$user]($style)"

[hostname]
ssh_only = false
format = "[@$hostname](bold green) "

[directory]
format = "in [$path](bold cyan) "

[character]
success_symbol = "[➜](bold green)"
error_symbol = "[✖](bold red)"
CONFIG

if ! grep -q "starship init bash" "$HOME/.bashrc"; then
    echo 'eval "$(starship init bash)"' >> "$HOME/.bashrc"
fi

sudo apt install -y neofetch

mkdir -p "$HOME/.config/neofetch"
cat > "$HOME/.config/neofetch/config.conf" << NEOCONFIG
print_info() {
    info title
    info underline
    info os
    info kernel
    info uptime
    info shell
    info resolution
    info de
    info wm
    info terminal
    info cpu
    info memory
    info gpu
    info packages
    info line
}
NEOCONFIG

if ! grep -q "neofetch" "$HOME/.bashrc"; then
    echo "neofetch" >> "$HOME/.bashrc"
fi

dconf write /org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom0/name "'Abrir wofi'"
dconf write /org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom0/command "'wofi --show drun'"
dconf write /org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom0/binding "'<Super>space'"

dconf write /org/gnome/desktop/wm/keybindings/tile-left "['<Super>
