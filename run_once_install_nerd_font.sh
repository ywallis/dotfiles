#!/bin/bash

# Set variables
FONT_NAME="JetBrainsMono"
FONT_DIR="$HOME/.local/share/fonts"
TEMP_DIR="$(mktemp -d)"

# Check for dependencies
if ! command -v curl &> /dev/null || ! command -v unzip &> /dev/null; then
    echo "❌ curl or unzip is not installed. Please install them and try again."
    exit 1
fi

# Download the font
echo "⏳ Downloading ${FONT_NAME} Nerd Font..."
curl -fLo "${TEMP_DIR}/${FONT_NAME}.zip" "https://github.com/ryanoasis/nerd-fonts/releases/latest/download/${FONT_NAME}.zip"

if [ $? -ne 0 ]; then
    echo "❌ Failed to download the font. Check the URL and your internet connection."
    rm -rf "${TEMP_DIR}"
    exit 1
fi

# Create font directory if it doesn't exist
mkdir -p "$FONT_DIR"

# Extract only font files
echo "📦 Extracting font files..."
unzip -q "${TEMP_DIR}/${FONT_NAME}.zip" -d "${TEMP_DIR}/extracted_fonts"

# Move font files to the font directory
find "${TEMP_DIR}/extracted_fonts" -type f \( -name "*.ttf" -o -name "*.otf" \) -exec mv -t "$FONT_DIR" {} +

# Clean up temporary directory
rm -rf "${TEMP_DIR}"

# Refresh font cache
echo "🔄 Updating font cache..."
fc-cache -f -v

echo "✅ ${FONT_NAME} Nerd Font installed successfully."
