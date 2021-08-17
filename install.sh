#!/bin/bash

# Check if root
if [[ $EUID -ne 0 ]]; then
  echo "This script must be run as root"
  exit 1
fi

# Make directory
echo "Creating theme directory"
sudo mkdir -p /boot/grub/themes/vanilla_enhanced
sudo mkdir -p /boot/grub/themes/vanilla_enhanced/icons

# Copy theme files
echo "Copying theme"
sudo cp theme.txt /boot/grub/themes/vanilla_enhanced/
sudo cp UBUNTU\ FONT\ LICENCE.txt /boot/grub/themes/vanilla_enhanced/
sudo cp ubuntu-regular-14.pf2 /boot/grub/themes/vanilla_enhanced/
sudo cp *.png /boot/grub/themes/vanilla_enhanced/
sudo cp icons/* /boot/grub/themes/vanilla_enhanced/icons

# Change parameter GRUB_THEME to use this theme
echo "Setting parameter GRUB_THEME"
sudo sed -i '/GRUB_THEME=/d' /etc/default/grub
sudo sed -i -e '$aGRUB_THEME=/boot/grub/themes/vanilla_enhanced/theme.txt' /etc/default/grub

# Update GRUB configuration
echo "Updating configuration"
sudo grub-mkconfig -o /boot/grub/grub.cfg
