#!/bin/bash

set -e

echo "🔥 Configurando Ubuntu Wayland PRO (100% Wayland Friendly) 🔥"

# 1. Actualizamos el sistema
sudo apt update && sudo apt upgrade -y

# 2. Instalar herramientas esenciales
sudo apt install -y wofi gnome-shell-extensions gnome-shell-extension-manager \
                    gnome-tweaks curl unzip

# 3. Configurar fuentes globales - Todo Avant Garde tamaño 12
echo "🖋️ Configurando fuentes globales a ITC Avant Garde Gothic Std 12"

gsettings set org.gnome.desktop.interface font-name 'ITC Avant Garde Gothic Std 12'
gsettings set org.gnome.desktop.interface document-font-name 'ITC Avant Garde Gothic Std 12'
gsettings set org.gnome.desktop.interface monospace-font-name 'ITC Avant Garde Gothic Std 12'

echo "✅ Fuentes configuradas: ITC Avant Garde Gothic Std 12 en todo el sistema"

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

# 6. Starship prompt (por si usas Bash, pero Zsh puede tener su propio setup después)
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

# 7. Neofetch (para que al abrir terminal salga el banner)
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

# 1️⃣ Registrar el atajo en la lista global (esto es lo que faltaba)
dconf write /org/gnome/settings-daemon/plugins-media-keys/custom-keybindings "['/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom0/']"

# 2️⃣ Definir el atajo personalizado
dconf write /org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom0/name "'Abrir wofi'"
dconf write /org/gnome/settings-daemon/plugins-media-keys/custom-keybindings/custom0/command "'wofi --show drun'"
dconf write /org/gnome/settings-daemon/plugins-media-keys/custom-keybindings/custom0/binding "'<Super>space'"

# 9. Tiling básico (ventanas divididas)
dconf write /org/gnome/desktop/wm/keybindings/tile-left "['<Super>Left']"
dconf write /org/gnome/desktop/wm/keybindings/tile-right "['<Super>Right']"
dconf write /org/gnome/desktop/wm/keybindings/maximize "['<Super>Up']"
dconf write /org/gnome/desktop/wm/keybindings/unmaximize "['<Super>Down']"

# 10. Cambiar idioma teclado (opcional)
dconf write /org/gnome/desktop/input-sources/xkb-options "['grp:win_space_toggle']"


# 9.1 Atajos adicionales - Cambiar foco entre ventanas sin moverlas
dconf write /org/gnome/desktop/wm/keybindings/switch-to-workspace-left "['<Super><Alt>Left']"
dconf write /org/gnome/desktop/wm/keybindings/switch-to-workspace-right "['<Super><Alt>Right']"

echo "✅ Atajos adicionales configurados:"
echo "   Super + Alt + Left  = Cambiar foco a ventana izquierda"
echo "   Super + Alt + Right = Cambiar foco a ventana derecha"

# Final
echo "✅ Configuración completa (100% Wayland Friendly)"
echo "✅ Fuentes configuradas: ITC Avant Garde Gothic Std 12"
echo "⚡ Tema: Yaru Dark"
echo "🌄 Fondo de pantalla: Tecnológico oscuro"
echo "💻 Lanzador: wofi (Super + Espacio)"
echo "🔥 Terminal: Starship + Neofetch"
