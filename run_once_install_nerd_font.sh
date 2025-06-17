#!/bin/bash

# Set variables
FONT_NAME="JetBrainsMono"
NERD_FONT_URL="https://github.com/ryanoasis/nerd-fonts/releases/latest/download/${FONT_NAME}.zip"
FONT_DIR="$HOME/.local/share/fonts"

# Create font directory if it doesn't exist
mkdir -p "$FONT_DIR"

# Download and unzip the font
echo "Downloading JetBrainsMono Nerd Font..."
curl -fLo /tmp/${FONT_NAME}.zip "$NERD_FONT_URL"

echo "Extracting font files..."
unzip -q /tmp/${FONT_NAME}.zip -d "$FONT_DIR"

# Clean up
rm /tmp/${FONT_NAME}.zip

# Refresh font cache
echo "Updating font cache..."
fc-cache -fv "$FONT_DIR"

echo "✅ JetBrainsMono Nerd Font installed successfully."

