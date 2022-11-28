#!/usr/bin/env bash

set -e

packages=( awesome rofi picom alacritty xterm ranger htop vim neovim vlc smplayer lutris wine winetricks xf86-input-wacom libwacom xorg-xinput lxappearance qt5ct neofetch nitrogen polkit-gnome ntfs-3g fuse bluez bluez-utils hplip flatpak gimp alsa-utils flameshot qbittorrent firefox piper calibre nodejs yarn npm rust gnome-boxes gparted os-prober pavucontrol unrar acpid xournalpp )

packages_options=( steam )

packages_yay=( google-chrome winff qt5-styleplugins grub-customizer hplip-plugin zsh ttf-meslo-nerd-font-powerlevel10k powerline-fonts awesome-terminal-fonts zsh-theme-powerlevel10k-git appimagelauncher visual-studio-code-bin )

packages_flatpak=( com.bitwarden.desktop com.discordapp.Discord com.heroicgameslauncher.hgl com.obsproject.Studio com.snes9x.Snes9x io.mgba.mGBA net.pcsx2.PCSX2 net.rpcs3.RPCS3 org.DolphinEmu.dolphin-emu org.citra_emu.citra org.duckstation.DuckStation org.fedoraproject.MediaWriter org.gnome.Calculator org.ppsspp.PPSSPP org.ryujinx.Ryujinx org.yuzu_emu.yuzu sh.ppy.osu )

sudo pacman -Syu
sudo pacman -S ${packages[@]} --noconfirm
sudo pacman -S ${packages_options[@]}

git clone https://aur.archlinux.org/yay.git
cd yay/
makepkg -si
cd ..
yay -S ${packages_yay[@]} --noconfirm

flatpak install ${packages_flatpak[@]} -y

git clone https://github.com/rarorza/awesome/
sudo cp -r awesome/ /$HOME/.config/
sudo cp -r /$HOME/.config/awesome/dotfiles/.scripts/ /$HOME/
sudo cp -r /$HOME/.config/awesome/dotfiles/alacritty/ /$HOME/.config/
sudo cp -r /$HOME/.config/awesome/dotfiles/alacritty/.local/share/fonts/ /$HOME/.local/share/
sudo cp -r /$HOME/.config/awesome/dotfiles/picom/ /$HOME/.config/
sudo cp -r /$HOME/.config/awesome/dotfiles/ranger/ /$HOME/.config/
sudo cp -r /$HOME/.config/awesome/dotfiles/zsh/.zshrc /$HOME/
sudo cp -r /$HOME/.config/awesome/dotfiles/rofi/themes/android_notification.rasi /usr/share/rofi/themes/
sudo cp -r /$HOME/.config/awesome/dotfiles/awesome/themes/Dark/ /usr/share/awesome/themes/
sudo cp -r /$HOME/.config/awesome/dotfiles/.scripts/rofi-power-menu/rofi-power-menu /usr/bin/
echo 'export QT_QPA_PLATFORMTHEME=qt5ct' | sudo tee -a /etc/environment

fc-cache -vf

sudo systemctl start bluetooth.service
sudo systemctl enable bluetooth.service

git clone https://github.com/zsh-users/zsh-autosuggestions ~/.zsh/zsh-autosuggestions
cargo install exa bat
chsh -s /usr/bin/zsh
