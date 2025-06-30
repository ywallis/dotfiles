#!/bin/sh

# Caps to Esc remapping using interception-tools

# Install dependencies
sudo add-apt-repository -y ppa:deafmute/interception
sudo apt update
sudo apt install -y interception-tools interception-caps2esc

# Create udevmon config
sudo tee /etc/interception/udevmon.yaml > /dev/null <<EOF
- JOB: "interception -g \$DEVNODE | caps2esc | uinput -d \$DEVNODE"
  DEVICE:
    EVENTS:
      EV_KEY: [KEY_CAPSLOCK, KEY_ESC]
EOF

# Add user to input group
sudo usermod -aG input "$USER"

# Prompt user to re-login or restart session
echo "Done. Please log out and back in (or restart your session) for group changes to take effect."

