#!/usr/bin/env bash

cd -

gsettings set org.gnome.desktop.screensaver lock-enabled false
gsettings set org.gnome.desktop.session idle-delay 0

sudo apt update -y
sudo apt upgrade -y
sudo apt dist-upgrade -y
sudo apt install nodejs unzip vlc libgtk-4-dev libadwaita-1-dev git ca-certificates curl golang npm tmux rofi git zsh ripgrep pavucontrol xclip jq tldr shutter python3-pip curl llvm lld llvm-dev clang libclang-dev libglib2.0-dev libgtk-4-dev gnome-tweak-tool flameshot libadwaita-1-dev git xclip flatpak gnome-software-plugin-flatpak obs-studio mpv -y
flatpak install -y flathub md.obsidian.Obsidian


################### INSTALL RUST ###################
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y
git config --global user.email "shonen787@gmail.com"
git config --global user.name "shonen"

################### FlatPak Installation ###################
sudo flatpak remote-add --if-not-exists flathub https://dl.flathub.org/repo/flathub.flatpakrepo

################### INSTALL ZIG ###################

wget https://ziglang.org/download/0.13.0/zig-linux-x86_64-0.13.0.tar.xz -O /tmp/zig.tar.xz
mkdir $HOME/.local
tar -xvf /tmp/zig.tar.xz -C $HOME/.local
export PATH="$HOME/.local/zig-linux-x86_64-0.13.0:$PATH"

################### Ghostty ###################

git clone https://github.com/ghostty-org/ghostty
cd ghostty
zig build -p $HOME/.local -Doptimize=ReleaseFast


################### Zoom ###################
# Make video calls using https://zoom.us/
cd /tmp
wget https://zoom.us/client/latest/zoom_amd64.deb
sudo apt install -y ./zoom_amd64.deb
rm zoom_amd64.deb
cd -

################### Steam ###################
# Play games from https://store.steampowered.com/
cd /tmp
wget https://cdn.akamai.steamstatic.com/client/installer/steam.deb
sudo apt install -y ./steam.deb
rm steam.deb
cd -

################### Spotify ###################
# Stream music using https://spotify.com
curl -sS https://download.spotify.com/debian/pubkey_C85668DF69375001.gpg | sudo gpg --dearmor --yes -o /etc/apt/trusted.gpg.d/spotify.gpg
echo "deb [signed-by=/etc/apt/trusted.gpg.d/spotify.gpg] http://repository.spotify.com stable non-free" | sudo tee /etc/apt/sources.list.d/spotify.list
sudo apt update -y
sudo apt install -y spotify-client

################### Chrome ###################
# Browse the web with the most popular browser. See https://www.google.com/chrome/
cd /tmp
wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb
sudo apt install -y ./google-chrome-stable_current_amd64.deb
rm google-chrome-stable_current_amd64.deb
xdg-settings set default-web-browser google-chrome.desktop
cd -

################### LocalSend ###################
cd /tmp
LOCALSEND_VERSION=$(curl -s "https://api.github.com/repos/localsend/localsend/releases/latest" | grep -Po '"tag_name": "v\K[^"]*')
wget -O localsend.deb "https://github.com/localsend/localsend/releases/latest/download/LocalSend-${LOCALSEND_VERSION}-linux-x86-64.deb"
sudo apt install -y ./localsend.deb
rm localsend.deb
cd -

################### Signal ###################
wget -qO- https://updates.signal.org/desktop/apt/keys.asc | gpg --dearmor >signal-desktop-keyring.gpg
cat signal-desktop-keyring.gpg | sudo tee /usr/share/keyrings/signal-desktop-keyring.gpg >/dev/null
echo 'deb [arch=amd64 signed-by=/usr/share/keyrings/signal-desktop-keyring.gpg] https://updates.signal.org/desktop/apt xenial main' |
	sudo tee /etc/apt/sources.list.d/signal-xenial.list
rm signal-desktop-keyring.gpg
sudo apt update
sudo apt install -y signal-desktop

################### VSCODE ###################
cd /tmp
wget -qO- https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor >packages.microsoft.gpg
sudo install -D -o root -g root -m 644 packages.microsoft.gpg /etc/apt/keyrings/packages.microsoft.gpg
echo "deb [arch=amd64,arm64,armhf signed-by=/etc/apt/keyrings/packages.microsoft.gpg] https://packages.microsoft.com/repos/code stable main" | sudo tee /etc/apt/sources.list.d/vscode.list >/dev/null
rm -f packages.microsoft.gpg
cd -

sudo apt update -y
sudo apt install -y code

################### Fonts ###################


mkdir -p ~/.local/share/fonts

cd /tmp
wget https://github.com/ryanoasis/nerd-fonts/releases/latest/download/CascadiaMono.zip
unzip CascadiaMono.zip -d CascadiaFont
cp CascadiaFont/*.ttf ~/.local/share/fonts
rm -rf CascadiaMono.zip CascadiaFont

wget -O iafonts.zip https://github.com/iaolo/iA-Fonts/archive/refs/heads/master.zip
unzip iafonts.zip -d iaFonts
cp iaFonts/iA-Fonts-master/iA\ Writer\ Mono/Static/iAWriterMonoS-*.ttf ~/.local/share/fonts
rm -rf iafonts.zip iaFonts

fc-cache
cd -




gsettings set org.gnome.desktop.screensaver lock-enabled true
gsettings set org.gnome.desktop.session idle-delay 300

