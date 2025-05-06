#!/run/current-system/sw/bin/bash
# Run script for Erisia Gallery Bot

set -e

export PATH=$PATH:/run/current-system/sw/bin

# Get the directory of this script
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# Run the bot using Nix to provide dependencies
nix-shell -p "python3.withPackages (ps: [ps.discordpy ps.aiohttp])" --run "cd $SCRIPT_DIR && python3 gallery_bot.py"
