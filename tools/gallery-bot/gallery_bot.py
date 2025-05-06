#!/usr/bin/env python3
"""
Erisia Gallery Bot

This bot collects images posted in a Discord channel and serves them via HTTP.
"""

import asyncio
import os
import logging
import datetime
import mimetypes
import json
import re
from pathlib import Path
import aiohttp
from aiohttp import web
import discord
from discord.ext import commands

# Configure logging
logging.basicConfig(
    level=logging.INFO,
    format='%(asctime)s - %(name)s - %(levelname)s - %(message)s'
)
logger = logging.getLogger('gallery-bot')

# Configuration
DATA_DIR = Path.home() / '.local' / 'share' / 'erisia-gallery'
CONFIG_DIR = Path.home() / '.config' / 'erisia-gallery'
CONFIG_FILE = CONFIG_DIR / 'config.json'
IMAGE_DIR = DATA_DIR / 'images'
THUMBNAIL_DIR = DATA_DIR / 'thumbnails'
METADATA_FILE = DATA_DIR / 'metadata.json'
DEFAULT_CONFIG = {
    'token': '',
    'channel_id': 0,
    'http_port': 24464,
    'http_host': '0.0.0.0',
    'max_images': 1000,
    'allowed_extensions': ['.png', '.jpg', '.jpeg', '.gif', '.webp', '.bmp', '.tiff', '.tif']
}

# Create necessary directories
DATA_DIR.mkdir(parents=True, exist_ok=True)
IMAGE_DIR.mkdir(exist_ok=True)
THUMBNAIL_DIR.mkdir(exist_ok=True)
CONFIG_DIR.mkdir(parents=True, exist_ok=True)

# Load or create config
if not CONFIG_FILE.exists():
    with open(CONFIG_FILE, 'w') as f:
        json.dump(DEFAULT_CONFIG, f, indent=4)
    logger.info(f"Created default config at {CONFIG_FILE}. Please edit it with your Discord token and channel ID.")
    exit(1)

with open(CONFIG_FILE, 'r') as f:
    config = json.load(f)
    # Ensure all needed keys are present
    for key, value in DEFAULT_CONFIG.items():
        if key not in config:
            config[key] = value

# Load or create metadata
if METADATA_FILE.exists():
    with open(METADATA_FILE, 'r') as f:
        try:
            metadata = json.load(f)
        except json.JSONDecodeError:
            metadata = {'images': []}
else:
    metadata = {'images': []}

# Create Discord bot
intents = discord.Intents.default()
intents.message_content = True
bot = commands.Bot(command_prefix='!', intents=intents)

# Create HTTP server routes
routes = web.RouteTableDef()

@routes.get('/debug')
async def debug(request):
    """Debug route to list all available images."""
    images = []
    for file_path in IMAGE_DIR.glob('*'):
        if file_path.is_file():
            images.append({
                'filename': file_path.name,
                'size': file_path.stat().st_size,
                'modified': datetime.datetime.fromtimestamp(file_path.stat().st_mtime).strftime('%Y-%m-%d %H:%M:%S')
            })
    
    html = f"""
    <!DOCTYPE html>
    <html>
    <head>
        <title>Gallery Debug</title>
    </head>
    <body>
        <h1>Available Images ({len(images)})</h1>
        <pre>
        {json.dumps(images, indent=2)}
        </pre>
    </body>
    </html>
    """
    
    return web.Response(text=html, content_type='text/html')

@routes.get('/')
async def index(request):
    """Serve the gallery index page."""
    try:
        with open(METADATA_FILE, 'r') as f:
            metadata = json.load(f)
    except (json.JSONDecodeError, FileNotFoundError):
        metadata = {'images': []}
    
    # Sort images by timestamp (newest first)
    images = sorted(metadata.get('images', []), 
                    key=lambda x: x.get('timestamp', 0), 
                    reverse=True)
    
    # Select 9 images for display in a 3x3 grid, with weighted random selection favoring newer images
    display_images = []
    if images:
        import random
        
        # Create weighted probabilities that favor newer images
        # Newer images (at the start of the list) get higher weights
        weights = []
        for i in range(len(images)):
            # Exponential decay - newer images are much more likely to be picked
            weights.append(0.9 ** i)
            
        # Normalize weights
        sum_weights = sum(weights)
        weights = [w / sum_weights for w in weights]
        
        # Select 9 random images based on weights, without replacement
        num_to_display = min(9, len(images))
        indices = random.choices(range(len(images)), weights=weights, k=len(images))
        
        # Take the first num_to_display unique indices
        unique_indices = []
        for idx in indices:
            if idx not in unique_indices:
                unique_indices.append(idx)
            if len(unique_indices) == num_to_display:
                break
                
        # If we didn't get enough unique images, fill with sequential ones
        if len(unique_indices) < num_to_display:
            for i in range(len(images)):
                if i not in unique_indices:
                    unique_indices.append(i)
                if len(unique_indices) == num_to_display:
                    break
        
        display_images = [images[i] for i in unique_indices]
    else:
        display_images = []
    
    html = """
    <!DOCTYPE html>
    <html lang="en">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Erisia Gallery</title>
        <style>
            body {
                font-family: Arial, sans-serif;
                max-width: 1200px;
                margin: 0 auto;
                padding: 20px;
                background-color: #121212;
                color: #e0e0e0;
            }
            h1 {
                text-align: center;
            }
            .gallery {
                display: grid;
                grid-template-columns: repeat(3, 1fr);
                grid-gap: 20px;
            }
            .gallery-item {
                border: 1px solid #383838;
                border-radius: 5px;
                overflow: hidden;
                background-color: #1e1e1e;
            }
            .gallery-image {
                width: 100%;
                aspect-ratio: 1;
                object-fit: cover;
                cursor: pointer;
            }
            .gallery-info {
                padding: 10px;
                font-size: 0.9em;
            }
            .modal {
                display: none;
                position: fixed;
                z-index: 999;
                left: 0;
                top: 0;
                width: 100%;
                height: 100%;
                background-color: rgba(0, 0, 0, 0.9);
            }
            .modal-content {
                margin: auto;
                display: block;
                max-width: 90%;
                max-height: 90%;
            }
            .close {
                position: absolute;
                top: 15px;
                right: 35px;
                color: #f1f1f1;
                font-size: 40px;
                font-weight: bold;
                cursor: pointer;
            }
            .modal-caption {
                margin: auto;
                display: block;
                width: 80%;
                text-align: center;
                color: #ccc;
                padding: 10px 0;
            }
        </style>
    </head>
    <body>
        <h1>Erisia Gallery</h1>
        <div class="gallery">
    """
    
    for idx, image in enumerate(display_images):
        filename = image.get('filename')
        username = image.get('username', 'Unknown')
        # Extract just the username part before the # discriminator
        display_name = username.split('#')[0] if '#' in username else username
        timestamp = image.get('timestamp', 0)
        date = datetime.datetime.fromtimestamp(timestamp).strftime('%Y-%m-%d')
        
        # Use path with /images/ prefix for reverse proxy
        image_url = f"/images/{filename}"
        
        html += f"""
        <div class="gallery-item">
            <img src="{image_url}" class="gallery-image" onclick="openModal(this)" alt="{filename}">
            <div class="gallery-info">
                <div>Posted by: {display_name}</div>
                <div>Date: {date}</div>
            </div>
        </div>
        """
    
    html += """
        </div>
        
        <!-- Modal for full-size image view -->
        <div id="imageModal" class="modal">
            <span class="close" onclick="closeModal()">&times;</span>
            <img class="modal-content" id="modalImage">
            <div id="caption" class="modal-caption"></div>
        </div>
        
        <script>
            function openModal(img) {
                const modal = document.getElementById("imageModal");
                const modalImg = document.getElementById("modalImage");
                const captionText = document.getElementById("caption");
                
                modal.style.display = "block";
                modalImg.src = img.src;
                captionText.innerHTML = img.alt;
            }
            
            function closeModal() {
                document.getElementById("imageModal").style.display = "none";
            }
            
            // Close modal when clicking outside the image
            window.onclick = function(event) {
                const modal = document.getElementById("imageModal");
                if (event.target == modal) {
                    closeModal();
                }
            }
            
            // Close modal with escape key
            document.addEventListener('keydown', function(event) {
                if (event.key === "Escape") {
                    closeModal();
                }
            });
        </script>
    </body>
    </html>
    """
    
    return web.Response(text=html, content_type='text/html')

@routes.get('/images/{filename}')
@routes.get('/{filename}')  # Also handle direct requests without /images/ prefix
async def serve_image(request):
    """Serve an image file."""
    filename = request.match_info['filename']
    
    # Ignore favicon.ico requests
    if filename == 'favicon.ico':
        return web.Response(status=404, text="Not found")
    
    file_path = IMAGE_DIR / filename
    
    # Log the file path to help with debugging
    logger.info(f"Requested image: {filename} from path: {file_path} (exists: {file_path.exists()})")
    
    if not file_path.exists() or not file_path.is_file():
        return web.Response(status=404, text=f"Image not found: {filename}")
    
    content_type, _ = mimetypes.guess_type(str(file_path))
    if not content_type:
        content_type = 'application/octet-stream'
    
    logger.info(f"Serving image: {filename} with content type: {content_type}")
    return web.FileResponse(file_path, headers={'Content-Type': content_type})

async def save_metadata():
    """Save metadata to disk."""
    try:
        with open(METADATA_FILE, 'w') as f:
            json.dump(metadata, f, indent=4)
    except Exception as e:
        logger.error(f"Failed to save metadata: {e}")

def extract_image_urls(content):
    """Extract image URLs from message content."""
    urls = []
    
    # Match common image URL patterns, including those with query parameters
    url_pattern = r'https?://[^\s<>"]+\.(?:png|jpg|jpeg|gif|webp|bmp|tiff|tif)(?:\?[^\s<>"]*)?(?:#[^\s<>"]*)?(?:\s|$|\b|<|>|")'
    matches = re.findall(url_pattern, content, re.IGNORECASE)
    urls.extend([match.strip('>"<,\'"').split()[0] for match in matches])
    
    # Match Discord CDN image URLs which might not have a file extension in the URL
    discord_pattern = r'https?://(?:cdn\.discordapp\.com|media\.discordapp\.net)/attachments/\d+/\d+/[^<>\s"]+(?:\s|$|\b|<|>|")'
    discord_matches = re.findall(discord_pattern, content, re.IGNORECASE)
    urls.extend([match.strip('>"<,\'"').split()[0] for match in discord_matches])
    
    # Remove duplicates while preserving order
    unique_urls = []
    for url in urls:
        if url not in unique_urls:
            unique_urls.append(url)
    
    return unique_urls

async def download_image(url, filename, username=None):
    """Download an image from URL and save it to the images directory."""
    try:
        async with aiohttp.ClientSession() as session:
            async with session.get(url) as response:
                if response.status == 200:
                    # Verify that the content is actually an image
                    content_type = response.headers.get('Content-Type', '').lower()
                    if not content_type.startswith('image/'):
                        # Check if the URL ends with a known image extension
                        ext = url.split('.')[-1].lower()
                        if ext not in ['png', 'jpg', 'jpeg', 'gif', 'webp', 'bmp', 'tiff', 'tif']:
                            logger.warning(f"URL {url} does not appear to be an image (Content-Type: {content_type})")
                            return False
                    
                    data = await response.read()
                    file_path = IMAGE_DIR / filename
                    with open(file_path, 'wb') as f:
                        f.write(data)
                    user_info = f" from user {username}" if username else ""
                    logger.info(f"Downloaded image: {filename}{user_info} (Content-Type: {content_type})")
                    return True
                else:
                    logger.error(f"Failed to download image from {url}: HTTP {response.status}")
                    return False
    except Exception as e:
        logger.error(f"Error downloading image from {url}: {e}")
        return False

@bot.event
async def on_ready():
    """Handle bot ready event."""
    logger.info(f'Logged in as {bot.user.name} ({bot.user.id})')
    logger.info(f'Monitoring channel ID: {config["channel_id"]}')
    logger.info(f'HTTP server starting on {config["http_host"]}:{config["http_port"]}')

    # Set up HTTP server
    app = web.Application()
    app.add_routes(routes)
    
    runner = web.AppRunner(app)
    await runner.setup()
    site = web.TCPSite(runner, config["http_host"], config["http_port"])
    await site.start()
    
    logger.info(f'HTTP server running at http://{config["http_host"]}:{config["http_port"]}/')
    logger.info('Images will be served at /images/{filename} path for reverse proxy')

@bot.event
async def on_message(message):
    """Process new messages in the monitored channel."""
    if message.channel.id != config["channel_id"]:
        return
    
    # Log the message
    logger.info(f"Message from {message.author}: {message.content}")
    
    # Check for images in attachments
    has_image = False
    for attachment in message.attachments:
        if any(attachment.filename.lower().endswith(ext) for ext in config["allowed_extensions"]):
            has_image = True
            # Generate unique filename
            timestamp = int(datetime.datetime.now().timestamp())
            unique_filename = f"{timestamp}_{attachment.filename}"
            
            # Download the image
            success = await download_image(attachment.url, unique_filename, str(message.author))
            if success:
                # Add to metadata
                image_metadata = {
                    'filename': unique_filename,
                    'original_filename': attachment.filename,
                    'message_id': message.id,
                    'channel_id': message.channel.id,
                    'username': str(message.author),
                    'user_id': message.author.id,
                    'timestamp': timestamp,
                    'url': attachment.url
                }
                
                metadata['images'].append(image_metadata)
                # Enforce max images limit
                if len(metadata['images']) > config['max_images']:
                    # Remove oldest images
                    to_remove = len(metadata['images']) - config['max_images']
                    oldest_first = sorted(metadata['images'], key=lambda x: x.get('timestamp', 0))
                    for old_image in oldest_first[:to_remove]:
                        old_filename = old_image.get('filename')
                        old_file_path = IMAGE_DIR / old_filename
                        if old_file_path.exists():
                            old_file_path.unlink()
                            logger.info(f"Removed old image: {old_filename}")
                    
                    metadata['images'] = oldest_first[to_remove:]
                
                await save_metadata()
    
    # Process any image URLs in the message content
    if message.content:
        image_urls = extract_image_urls(message.content)
        if image_urls:
            logger.info(f"Found {len(image_urls)} image URLs in message from {message.author}")
            for url in image_urls:
                # Extract the filename from the URL
                url_filename = url.split('/')[-1].split('?')[0]  # Remove query parameters
                timestamp = int(datetime.datetime.now().timestamp())
                unique_filename = f"{timestamp}_{url_filename}"
                
                # Download the image
                success = await download_image(url, unique_filename, str(message.author))
                if success:
                    has_image = True
                    # Add to metadata
                    image_metadata = {
                        'filename': unique_filename,
                        'original_filename': url_filename,
                        'message_id': message.id,
                        'channel_id': message.channel.id,
                        'username': str(message.author),
                        'user_id': message.author.id,
                        'timestamp': timestamp,
                        'url': url
                    }
                    
                    metadata['images'].append(image_metadata)
                    # Enforce max images limit
                    if len(metadata['images']) > config['max_images']:
                        # Remove oldest images
                        to_remove = len(metadata['images']) - config['max_images']
                        oldest_first = sorted(metadata['images'], key=lambda x: x.get('timestamp', 0))
                        for old_image in oldest_first[:to_remove]:
                            old_filename = old_image.get('filename')
                            old_file_path = IMAGE_DIR / old_filename
                            if old_file_path.exists():
                                old_file_path.unlink()
                                logger.info(f"Removed old image: {old_filename}")
                        
                        metadata['images'] = oldest_first[to_remove:]
                    
                    await save_metadata()
    
    # Log if no gallery-suitable images were found in the message
    if not has_image and (message.attachments or (message.content and re.search(r'https?://', message.content))):
        logger.info(f"Message had attachments or URLs but no gallery-suitable images from {message.author}")
    
    await bot.process_commands(message)

def main():
    """Main entry point."""
    if not config['token']:
        logger.error("Discord token not set in config file")
        exit(1)
    
    if not config['channel_id']:
        logger.error("Channel ID not set in config file")
        exit(1)
    
    logger.info("Starting Erisia Gallery Bot")
    bot.run(config['token'])

if __name__ == "__main__":
    main()
