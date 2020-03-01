#!/bin/bash
# Install fd, bat, zsh, etc.

# Basics
sudo apt-get install wget curl git

# Clone dotfiles
git clone https://github.com/iiwolf/dotfiles.git

# Utility
sudo apt-get install openvpn
sudo apt-get install network-manager-openvpn-gnome
sudo apt-get install openssh-server

# Editors
sudo apt-get install emacs
sudo snap install --classic code

# Tools
sudo apt-get install autojump
sudo apt-get install zsh
sudo dpkg -i $HOME/Downloads/debs/fd_7.3.0_amd64.deb  # adapt version number and architecture
sudo dpkg -i bat_0.11.0_amd64.deb  # adapt version number and architecture

# i3-gaps and requirements
sudo apt-get install libxcb-xrm-dev
~/dotfiles/bin/install_i3.sh