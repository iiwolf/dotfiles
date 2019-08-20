#!/bin/bash
# Install fd, bat, zsh, etc.

sudo apt-get install zsh
sudo dpkg -i $HOME/Downloads/debs/fd_7.3.0_amd64.deb  # adapt version number and architecture
sudo dpkg -i bat_0.11.0_amd64.deb  # adapt version number and architecture