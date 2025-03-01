#!/bin/bash

set -e

echo "🔥 Configurando Ubuntu Wayland PRO (100% Wayland Friendly) 🔥"

# 1. Actualizamos
sudo apt update && sudo apt upgrade -y

# 2. Instalar herramientas esenciales
sudo apt install -y wofi gnome-shell-extensions gnome-shell-extension-manager \
                    fonts-jetbrains-mono fonts-firacode fonts-roboto fonts-roboto-mono \
                    gnome-tweaks curl unzip

# 3. Configurar fuentes globales a Roboto
echo "🖋️ Configurando fuente global a Roboto"
gsettings set org.gnome.desktop.interface font-name 'Roboto 11'
gsettings set org.gnome.desktop.interface document-font-name 'Roboto 11'
gsettings set org.gnome.desktop.interface monospace-font-name 'Roboto Mono 11'

# 4. Configurar tema oscuro Yaru
gsettings set org.gnome.desktop.interface gtk-theme 'Yaru-dark'
gsettings set org.gnome.desktop.interface icon-theme 'Yaru'
gsettings set org.gnome.desktop.interface cursor-theme 'Yaru'
gsettings set org.gnome.desktop.interface color-scheme 'prefer-dark'

# 5. Fondo de pantalla
WALLPAPER_DIR="$HOME/Pictures/Wallpapers"
mkdir -p "$WALLPAPER_DIR"
cp ./assets/wallpaper.png "$WALLPAPER_DIR/wayland_pro_wallpaper.png"
gsettings set org.gnome.desktop.background picture-uri "file://$WALLPAPER_DIR/wayland_pro_wallpaper.png"
gsettings set org.gnome.desktop.background picture-options 'zoom'

# 6. Starship prompt
curl -sS https://starship.rs/install.sh | sh -s -- -y

mkdir -p "$HOME/.config"
cat > "$HOME/.config/starship.toml" << 'CONFIG'
format = "$username@$hostname $directory $git_branch$git_status $character"

[username]
style_user = "bold green"
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

# 7. Neofetch
sudo apt install -y neofetch

mkdir -p "$HOME/.config/neofetch"
cat > "$HOME/.config/neofetch/config.conf" << 'NEOCONFIG'
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

# 8. Atajos de teclado (con wofi)
dconf write /org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom0/name "'Abrir wofi'"
dconf write /org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom0/command "'wofi --show drun'"
dconf write /org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom0/binding "'<Super>space'"

# Tiling básico (GNOME)
dconf write /org/gnome/desktop/wm/keybindings/tile-left "['<Super>Left']"
dconf write /org/gnome/desktop/wm/keybindings/tile-right "['<Super>Right']"
dconf write /org/gnome/desktop/wm/keybindings/maximize "['<Super>Up']"
dconf write /org/gnome/desktop/wm/keybindings/unmaximize "['<Super>Down']"

# Cambiar idioma teclado (opcional)
dconf write /org/gnome/desktop/input-sources/xkb-options "['grp:win_space_toggle']"

# Mensaje final
echo "✅ Configuración completa (100% Wayland Friendly)"
echo "📋 Fuente aplicada: Roboto 11"
echo "⚡ Tema: Yaru Dark"
echo "🌄 Fondo de pantalla: Tecnológico oscuro"
echo "💻 Lanzador: wofi (Super + Espacio)"
echo "🔥 Terminal: Starship + Neofetch"

