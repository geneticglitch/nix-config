#!/bin/bash

# Exit on any error
set -e

# Check if script is run as root
if [ "$EUID" -ne 0 ]; then
  echo "Please run as root"
  exit
fi

# Copy configuration files
echo "Copying configuration files..."
cp ./configuration.nix /etc/nixos/configuration.nix
cp ./home.nix /etc/nixos/home.nix
cp ./starship.toml /etc/nixos/starship.toml

# Copy dotfiles
echo "Copying dotfiles..."
cp -r ./dotfiles /etc/nixos

# Add Home Manager channel
echo "Adding Home Manager channel..."
nix-channel --add https://github.com/nix-community/home-manager/archive/release-24.05.tar.gz home-manager
nix-channel --update

# Rebuild NixOS
echo "Rebuilding NixOS..."
nixos-rebuild switch

# Reboot
echo "Installation complete. Rebooting in 5 seconds..."
sleep 5
reboot
