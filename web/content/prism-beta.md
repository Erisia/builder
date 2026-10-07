---
title: Prism Launcher install (beta)
---

**This is a beta.** The normal way to play is still [MCUpdater](/getting-started/), and it isn't
going anywhere. This page is for players who'd like to help test a Prism-native install of E36.
If something goes wrong, tell us in [Discord](https://discord.gg/VW9x7sR); your MCUpdater
install is untouched either way.

## What's different

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
