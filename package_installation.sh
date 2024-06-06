#!/bin/sh

## Installing packages using pacman  

# Updating the package list
sudo pacman -Syu --noconfirm

# Reading the package names from the packages.txt and installing them in order
while IFS= read -r package;do
	sudo pacman -S --noconfirm "$package"
done < pacman_packages.txt

# Installing "yay" "AUR helper"
git clone https://aur.archlinux.org/yay.git 
cd yay
makepkg -si --noconfirm

# Cleaning up
cd ..
rm -rf yay

## Installing packages from the aur repository

# Update package lists
yay -Syu --noconfirm

# Install AUR packages listed in aur_package_list.txt
while IFS= read -r package; do
	yay -S --noconfirm "$package"
done < aur_packages.txt
