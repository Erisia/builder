# Erisia Gallery Bot

A Discord bot that automatically collects images posted in a specified Discord channel and serves them through a web gallery.

## Features

- Monitors a Discord channel for image attachments
- Automatically downloads and stores images locally
- Serves a responsive web gallery to display the images
- Limits total number of stored images (configurable)
- Records metadata including username and timestamp
- Dark mode UI that matches the Erisia website theme

## Installation

1. Run the installation script:
   ```bash
   ./tools/gallery-bot/install.sh
   ```
2. Edit the configuration file:
   ```bash
   nano ~/.config/erisia-gallery/config.json
   ```
   Set your Discord bot token and channel ID.
3. Enable lingering for the user service (optional, but recommended for servers):
   ```bash
   loginctl enable-linger $USER
   ```

The bot will automatically use Nix to manage Python dependencies when running.

## Configuration

The configuration file is located at `~/.config/erisia-gallery/config.json` and contains:

```json
{
    "token": "",          // Discord bot token
    "channel_id": 0,      // Discord channel ID to monitor
    "http_port": 8080,    // HTTP server port
    "http_host": "0.0.0.0", // HTTP server host
    "max_images": 1000,   // Maximum number of images to store
    "allowed_extensions": [".png", ".jpg", ".jpeg", ".gif", ".webp"] // Allowed file types
}
```

## Usage

### Starting and stopping the service

```bash
# Start the bot
systemctl --user start gallery-bot

# Stop the bot
systemctl --user stop gallery-bot

# Enable at login
systemctl --user enable gallery-bot

# Check status
systemctl --user status gallery-bot

# View logs
journalctl --user -u gallery-bot -f
```

### Accessing the gallery

The gallery is accessible via HTTP at:
```
http://your-server-ip:8080
```

## Adding to your website

To integrate this gallery with a Hugo website, add a gallery page that loads content from the HTTP server.

### Manual Testing

You can run the bot manually (without systemd) for testing:

```bash
# Using the run script (recommended)
./tools/gallery-bot/run.sh

# Or directly with Nix
nix-shell -p "python3.withPackages (ps: [ps.discordpy ps.aiohttp])" --run "cd /home/minecraft/builder/tools/gallery-bot && python3 gallery_bot.py"
```

## Directory Structure

- Images are stored in `~/.local/share/erisia-gallery/images/`
- Metadata is stored in `~/.local/share/erisia-gallery/metadata.json`
- Configuration is stored in `~/.config/erisia-gallery/config.json`

## Creating a Discord Bot

1. Go to the [Discord Developer Portal](https://discord.com/developers/applications)
2. Create a new application
3. Go to the "Bot" tab and click "Add Bot"
4. Copy the token and add it to your config file
5. Under the "Privileged Gateway Intents" section, enable "Message Content Intent"
6. Go to the "OAuth2" tab, select "bot" scope and "Read Messages/View Channels" and "Read Message History" permissions
7. Use the generated URL to add the bot to your server

## Troubleshooting

- Check the logs: `sudo journalctl -u gallery-bot -f`
- Verify the bot has proper permissions in the Discord channel
- Ensure the configuration file contains the correct token and channel ID
- Check that the HTTP port is not blocked by a firewall