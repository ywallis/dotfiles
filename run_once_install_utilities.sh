#!/bin/sh

# Venv support outside uv
sudo apt install -y python3-venv

# Bat iso cat
sudo apt install -y bat
mkdir -p ~/.local/bin
ln -s /usr/bin/batcat ~/.local/bin/bat

# Fd iso find
sudo apt install -y fd-find
ln -s $(which fdfind) ~/.local/bin/fd

# LSD iso ls

sudo apt install -y lsd

# Caps to esc

sudo add-apt-repository ppa:deafmute/interception
sudo apt install interception-caps2esc
