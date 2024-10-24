#!/usr/bin/env bash

set -e

# Pacman packages
packages=( 
    # nvim 
    fd
    ripgrep
    lazygit
    gdu
    bottom
    # asdf
    openssl 
    zlib 
    xz 
    tk
    #
    kio-gdrive 
    #
    egl-wayland
    hyprpaper
    waybar
    tofi # yay
    nwg-look # lx substitute
    #
    awesome 
    rofi 
    picom 
    alacritty 
    kitty 
    xterm 
    ranger 
    pcmanfm # file manager
    gvfs # file manager
    bashmount 
    htop 
    neofetch 
    feh 
    gwenview
    mupdf 
    xreader # xfce
    transh-cli 
    vim 
    neovim 
    nvidia-settings 
    gamemode 
    lib32-gamemode 
    lutris 
    wine 
    winetricks 
    xf86-input-wacom 
    libwacom 
    kcm-wacomtablet 
    xorg-xinput 
    lxappearance 
    qt5ct # qt5 version
    qt5-styleplugins # qt5 version
    qt6ct # qt6 version
    qt6gtk2  # qt6 version
    nitrogen 
    polkit-gnome 
    ntfs-3g 
    fuse 
    blueman 
    bluez 
    bluez-utils 
    bluez-tools
    hplip 
    skanlite 
    alsa-utils 
    pavucontrol 
    lib32-pipewire 
    flameshot 
    firefox 
    chromium 
    piper 
    calibre 
    gnome-boxes 
    gparted 
    unrar 
    acpid 
    xournalpp 
    libreoffice-still 
    xorg-xkill 
    nodejs 
    yarn 
    npm 
    pnpm
    rust 
    docker 
    docker-compose 
    python-pip 
    gimp 
    vlc 
    okular # pdf reader
    smplayer 
    breeze-gtk 
    gufw 
    kolourpaint 
    qbittorrent 
    adobe-source-han-sans-jp-fonts 
    adobe-source-han-sans-kr-fonts 
    adobe-source-han-sans-cn-fonts 
    noto-fonts-emoji
    ark # qt
    peazip-qt-bin # ark alternative yay
    file-roller # gtk
    kcalc 
    jdk-openjdk 
    kdialog 
    tor 
    torbrowser-launcher 
    nyx 
    vulkan-tools 
    mesa-demos 
    pycharm-community-edition 
    ttf-fira-code 
    ttf-hack-nerd 
    ttf-meslo-nerd 
    ttf-jetbrains-mono-nerd 
    gnome-keyring 
    sqlitebrowser 
    go 
    leafpad 
    linux-headers 
    xclip 
    dotnet-runtime 
    dotnet-sdk 
    aspnet-runtime 
    dbeaver 
    obs-studio 
    telegram-desktop 
    gnome-themes-extra # to apply dark theme in legacy apps
    xf86-input-synaptics # touch pad, copy file in "cp /usr/share/X11/xorg.conf.d/70-synaptics.conf /etc/X11/xorg.conf.d/"
    goverlay
    mangohud
    lib32-mangohud
    dolphin
    ffmpegthumbs # kde thumbnail in video archive
    ffmpegthumbnailer
    steam 
    nvidia 
    base-devel 
    flatpak 
    zsh 
    lightdm-gtk-greeter-settings
    yt-dlp # download videos youtube
    )

# AUR packages
packages_yay=( 
    google-chrome 
    winff 
    qt5-styleplugins 
    hplip-plugin 
    powerline-fonts 
    awesome-terminal-fonts 
    visual-studio-code-bin 
    rofi-power-menu 
    asdf-vm 
    upscayl-bin 
    clang-format-all-git 
    ttf-ms-fonts 
    minecraft-launcher 
    selectdefaultapplication-git 
    vkbasalt # https://github.com/crosire/reshade-shaders
    bashmount 
    ventoy-bin 
    heroic-games-launcher-bin 
    )

# Flatpak packages
packages_flatpak=( 
    com.discordapp.Discord 
    org.telegram.desktop
    org.duckstation.DuckStation 
    net.pcsx2.PCSX2 
    org.ppsspp.PPSSPP 
    org.citra_emu.citra 
    org.ryujinx.Ryujinx 
    org.yuzu_emu.yuzu 
    info.cemu.Cemu
    org.libretro.RetroArch
    com.heroicgameslauncher.hgl
    net.lutris.Lutris 
    com.obsproject.Studio
    net.davidotek.pupgui2 
    com.rustdesk.RustDesk
    it.mijorus.gearlever 
    io.dbeaver.DBeaverCommunity
    md.obsidian.Obsidian
    net.ankiweb.Anki
    org.libreoffice.LibreOffice
    org.mozilla.firefox
    org.qbittorrent.qBittorrent
    org.upscayl.Upscayl
    org.gimp.GIMP
    )

# Npm packages
packages_npm=( 
    live-server 
    prettier 
    pyright 
    )

packages_cargo=( 
    tree-sitter-cli
    )

# Install pacman packages
sudo pacman -Syu
sudo pacman -S ${packages[@]} --noconfirm
sudo pacman -S ${packages_options[@]}

# Install YAY
cd ..
git clone https://aur.archlinux.org/yay.git
cd yay/
makepkg -si
cd ..
yes | rm -r yay/

# Install AUR packages
# yay -S ${packages_yay[@]} --noconfirm
yay -S ${packages_yay[@]}

# Install flatpak packages
flatpak install flathub ${packages_flatpak[@]} -y

# Install npm packages
mkdir dev/
cd dev/
sudo npm install -g ${packages_npm[@]}
cd ..

# AwesomeWM and general config files
git clone https://github.com/rarorza/window_manager.git
cd window_manager/
cp -r awesome/ /$HOME/.config/
cp -r i3/ /$HOME/.config/
cd ..
yes | rm -r awesome/
cp -r /$HOME/.config/awesome/dotfiles/.scripts/ /$HOME/
cp -r /$HOME/.config/awesome/dotfiles/alacritty/ /$HOME/.config/
cp -r /$HOME/.config/awesome/dotfiles/kitty/ /$HOME/.config/
cp -r /$HOME/.config/awesome/dotfiles/picom/ /$HOME/.config/
cp -r /$HOME/.config/awesome/dotfiles/ranger/ /$HOME/.config/
cp -r /$HOME/.config/awesome/dotfiles/zsh/.zshrc /$HOME/
cp -r /$HOME/.config/awesome/dotfiles/Xresources/.Xresources /$HOME/
sudo cp -r /$HOME/.config/awesome/dotfiles/rofi/themes/dmenu.rasi /usr/share/rofi/themes/
sudo cp -r /$HOME/.config/awesome/dotfiles/awesome/themes/Dark/ /usr/share/awesome/themes/
#sudo cp -r /$HOME/.config/awesome/dotfiles/.scripts/rofi-power-menu/rofi-power-menu /usr/bin/
echo 'export QT_QPA_PLATFORMTHEME=qt5ct' | sudo tee -a /etc/environment

# Oh-my-zsh! -> https://ohmyz.sh/
sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

# Zsh Autosuggestions
# https://github.com/zsh-users/zsh-autosuggestions
git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions

# Zsh Syntax Highlighting
# https://github.com/zsh-users/zsh-syntax-highlighting
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting

# Starship - > https://starship.rs/

# Auto update/save DNS
sudo cp -r /$HOME/.config/awesome/dotfiles/resolv/resolv.conf.override /etc/
sudo cp -r /$HOME/.config/awesome/dotfiles/resolv/zoverride.sh /etc/NetworkManager/dispatcher.d/
sudo chown root:root /etc/NetworkManager/dispatcher.d/zoverride.sh
sudo chmod 755 /etc/NetworkManager/dispatcher.d/zoverride.sh
sudo systemctl enable NetworkManager-dispatcher.service
sudo systemctl start NetworkManager-dispatcher.service

# Start and enable bluetooth
sudo systemctl start bluetooth.service
sudo systemctl enable bluetooth.service
# Uncomment AutoEnable=true /etc/bluetooth/main.conf

# Enable firewall
sudo ufw default deny incoming
sudo ufw enable
sudo ufw reload
sudo systemctl start ufw.service
sudo systemctl enable ufw.service 

# Enable docker
sudo systemctl enable --now docker docker.socket containerd  
sudo groupadd docker 
sudo usermod -aG docker $USER

# Install fonts
fc-cache -vf

# Install addons for ZSH
chsh -s /usr/bin/zsh
