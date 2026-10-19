---
title: Getting Started
weight: 10
menu: main
---

The recommended way to play E36 is with [Prism Launcher](https://prismlauncher.org/). First of all, join
[Discord](https://discord.gg/VW9x7sR): it's linked to the servers, and it's the place to get help or just hang out.

## How it works

The Prism instance downloads nothing up front. Every time you launch it, it first syncs its mods and
configs with the server's pack (using [packwiz-installer](https://github.com/packwiz/packwiz-installer)),
then starts the game. Mods removed from the pack are removed from your instance too, which
MCUpdater doesn't always manage. Mods you add yourself are left alone.

## Installing

1. Install [Prism Launcher](https://prismlauncher.org/) and log in with your Microsoft account.
2. In Prism's settings, under **Java**, make sure automatic Java download/detection is on.
   E36 runs on [Cleanroom](https://github.com/CleanroomMC/Cleanroom), like the server, which needs
   Java 25; Prism will fetch it for you. If you already play E36 through the Cleanroom template in
   Prism, this is the same setup, except that the mods now update themselves.
3. Click **Add Instance** → **Import**, and paste this URL:
   `https://madoka.brage.info/pack/prism/e36/E36.zip`
4. Launch the new **E36** instance. The first launch downloads about 400 MB. A window shows the
   progress and lets you choose the optional mods. Later launches only download what changed.
5. The instance gets 6 GB of memory by default. Change it under **Edit** → **Settings** → **Java**
   if your computer has more or less to spare; going below 4 GB is likely to cause problems.

## Connecting

The server only accepts connections from addresses that have been let in. Before connecting:

1. Open [punch.brage.info](https://punch.brage.info) on the computer you play from and log in with
   Discord. You need the Minecraft role on our Discord server, and to be on the whitelist; ask in
   Discord to get both. If you just got the role, log in to punch again.
2. Punch opens the server to your internet address for 14 days. Visiting the page again, or playing,
   renews it.
3. Connect to `minecraft.brage.info`.

If you can't connect after changing network, IP address or VPN, visit punch again.

## Bringing your things over from MCUpdater

Copy these from your MCUpdater E36 instance folder (under `~/.MCUpdater` on Linux,
`%APPDATA%/.MCUpdater` on Windows) into the Prism instance's `minecraft` folder
(**Edit** → **Folder** in Prism): `saves/`, `journeymap/`, `screenshots/`, `options.txt` and
`servers.dat`.

## Good to know

- If the pack server can't be reached, the sync window lets you continue and play with what you
  have.
- If you edit one of the pack's config files, your edit stays until the pack changes that file;
  then the pack's version replaces it.
- If a launch fails at the sync step, please copy the text of the error window into Discord.

## Legacy: MCUpdater

The old MCUpdater install still works, but it's no longer the recommended route. If you already
use it, see "Bringing your things over from MCUpdater" above to switch.

To get started:

1. Make sure you have 64-bit Java 17 (or newer) installed.
2. Download and run [MCU-Bootstrap](/MCU-Bootstrap.jar).
3. Select the correct instance from the instance list, on the left.
4. Take a look at the mods list. Many of these are optional. Defaults have been provided, but use your own judgement.
5. Click update
6. After you've updated the pack and run the link script, you may want to tweak the memory allocation of the pack in PrismLauncher. Default values are provided for the pack when the script creates a linked pack entry, but if you have the RAM for it, more memory may improve performance. Or you could reduce the memory consumption if you are using a weaker computer, though going below a maximum of 4GB is likely to cause problems.
7. Click launch.

If you're lucky, this will let you into Erisia. If not, please make sure you're actually using 64-bit Java 8; if you aren't using that, you're going to need to delete the installation directory before trying again. Otherwise, ask for assistance in Discord.

Depending on your OS, here's where to find it:

- Linux: ~/.MCUpdater
- OS X: ~/Library/Application Support/MCUpdater
- Windows: %APPDATA%/.MCUpdater
