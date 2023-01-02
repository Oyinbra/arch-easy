#!/bin/bash

sudo timedatectl set-ntp true
sudo hwclock --systohc

reflector --country US --latest 6 --sort rate --save /etc/pacman.d/mirrorlist

# Paru Installation
git clone https://aur.archlinux.org/paru.git
cd paru/
makepkg -si --noconfirm

sudo pacman -S --noconfirm xorg sddm plasma alacritty latte-dock kate dolphin spectacle xorg breeze-gtk kde-gtk-config xdg-desktop-portal xdg-desktop-portal-kde

sudo systemctl enable sddm
/bin/echo -e "\e[1;32mREBOOTING IN 5..4..3..2..1..\e[0m"
sleep 5
reboot
