#!/bin/bash

# Function to display generations and prompt for deletion
choose_generations() {
    echo "Current generations:"
    sudo nix-env --list-generations --profile /nix/var/nix/profiles/system
    echo ""
    read -p "Enter the numbers of the generations you want to delete (space-separated, e.g., '2 3'): " generations_to_delete
    echo ""
    return 0
}

# Main script
echo "NixOS Generation Cleanup Script"
echo "--------------------------------"

choose_generations

if [ -z "$generations_to_delete" ]; then
    echo "No generations selected for deletion. Exiting."
    exit 0
fi

echo "Deleting selected generations..."
sudo nix-env --delete-generations $generations_to_delete --profile /nix/var/nix/profiles/system

echo "Running garbage collector..."
sudo nix-collect-garbage -d

echo "Updating GRUB menu..."
sudo nixos-rebuild boot

echo "Cleanup complete. Current generations:"
sudo nix-env --list-generations --profile /nix/var/nix/profiles/system
