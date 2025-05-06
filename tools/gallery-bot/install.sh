#!/usr/bin/env bash
# Installation script for the Erisia Gallery Bot

set -e

echo "Installing Erisia Gallery Bot..."

# Create configuration directory
CONFIG_DIR="${HOME}/.config/erisia-gallery"
mkdir -p "$CONFIG_DIR"

# Create config file if it doesn't exist
CONFIG_FILE="${CONFIG_DIR}/config.json"
if [ ! -f "$CONFIG_FILE" ]; then
    echo "Creating default configuration file..."
    cat > "$CONFIG_FILE" << EOF
{
    "token": "",
    "channel_id": 0,
    "http_port": 8080,
    "http_host": "0.0.0.0",
    "max_images": 1000,
    "allowed_extensions": [".png", ".jpg", ".jpeg", ".gif", ".webp"]
}
EOF
    echo "Please edit $CONFIG_FILE and add your Discord token and channel ID"
fi

# Create user systemd directory if it doesn't exist
USER_SYSTEMD_DIR="${HOME}/.config/systemd/user"
mkdir -p "$USER_SYSTEMD_DIR"

# Copy service file
echo "Installing systemd user service..."
cp "$(dirname "$0")/gallery-bot.service" "$USER_SYSTEMD_DIR/"

# Reload systemd user daemon
systemctl --user daemon-reload

echo "Installation complete!"
echo "Please edit $CONFIG_FILE with your Discord token and channel ID"
echo ""
echo "Commands to manage the bot:"
echo "  Start:   systemctl --user start gallery-bot"
echo "  Stop:    systemctl --user stop gallery-bot"
echo "  Enable:  systemctl --user enable gallery-bot (start on login)"
echo "  Status:  systemctl --user status gallery-bot"
echo "  Logs:    journalctl --user -u gallery-bot -f"
echo ""
echo "After configuring, start the bot with:"
echo "  systemctl --user start gallery-bot"
echo ""
echo "The gallery will be available at http://localhost:8080"
echo ""
echo "To enable lingering (run as user service even when not logged in):"
echo "  loginctl enable-linger $USER"