#!/usr/bin/env bash

mkdir setup
cd setup

gsettings set org.gnome.desktop.screensaver lock-enabled false
gsettings set org.gnome.desktop.session idle-delay 0

sudo apt update -y
sudo apt upgrade -y
sudo apt dist-upgrade -y
sudo apt install nodejs unzip ca-certificates curl golang npm tmux rofi git zsh ripgrep pavucontrol xclip jq tldr shutter python3-pip curl llvm lld llvm-dev clang libclang-dev libglib2.0-dev libgtk-4-dev libadwaita-1-dev git xclip flatpak gnome-software-plugin-flatpak -y


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
zig build -Doptimize=ReleaseFast



