#!/bin/bash
usr=$(whoami)
program=i3
ln -s /home/$usr/dotfiles/regolith/$program/config /home/$usr/.config/regolith/$program/config
program=compton
ln -s /home/$usr/dotfiles/regolith/$program/config /home/$usr/.config/regolith/$program/config