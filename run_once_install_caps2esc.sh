#!/bin/sh

# Caps to esc

sudo add-apt-repository -y ppa:deafmute/interception
sudo apt install -y interception-tools
sudo apt install -y interception-caps2esc

# Add config

sudo echo "- JOB: "interception -g $DEVNODE | caps2esc | uinput -d $DEVNODE"
  DEVICE:
    EVENTS:
      EV_KEY: [KEY_CAPSLOCK, KEY_ESC]
" >> /etc/interception/udevmon.yaml

# Add user to relevant group
sudo usermod -aG input $USER
newgrp input

