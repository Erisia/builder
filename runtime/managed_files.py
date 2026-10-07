"""Which files in a world directory the pack put there, and retiring the ones it no longer ships.

start.py copies the pack's directories (config/, scripts/, ...) into the world on every start.
Some mods also write generated data into those directories, so a file the pack doesn't ship
can't be deleted just for that. Instead, every start records the files it copied in a manifest
(`.erisia-managed.json`). On the next start, a file that was in the old manifest but isn't in the
new one was dropped from the pack: it's moved to `.erisia-removed/<stamp>/`, not deleted, so an
admin can put it back. With no old manifest (the first start), nothing is retired.

A manifest that exists but can't be trusted (unparseable, wrong version, unsafe paths), or a file
that can't be moved, raises ManagedFilesError: start.py then refuses to start, so an admin finds
out before anything else is changed on a wrong basis (Baughn, 2026-10-07).

Consumers: start.py's sync step. Tests: tests/test_managed_files.py.
"""

from __future__ import annotations

import json
import os
import shutil
from collections.abc import Callable, Iterable
from pathlib import Path, PurePosixPath

MANIFEST_NAME = ".erisia-managed.json"
REMOVED_DIR_NAME = ".erisia-removed"
MANIFEST_VERSION = 1


class ManagedFilesError(Exception):
    """The manifest can't be trusted, or a dropped file couldn't be retired."""


def shipped_files(base: Path, dirs: Iterable[str]) -> set[str]:
    """Every file the pack ships under `base`/<dir>, as world-relative POSIX paths.

    `base` is the server in the Nix store, where files may be symlinks; they count as files.
    """
    files: set[str] = set()
    for name in dirs:
        root = base / name
        if not root.is_dir():
            continue
        for dirpath, _dirnames, filenames in os.walk(root, followlinks=True):
            for filename in filenames:
                path = Path(dirpath) / filename
                files.add(path.relative_to(base).as_posix())
    return files


def is_safe(rel: str) -> bool:
    """Whether `rel` is a plain relative path that stays inside the world directory."""
    path = PurePosixPath(rel)
    return bool(path.parts) and not path.is_absolute() and ".." not in path.parts


def read_manifest(world: Path) -> set[str] | None:
    """The files the previous start recorded, or None if there's no manifest yet.

    Raises ManagedFilesError if there is one but it can't be trusted.
    """
    path = world / MANIFEST_NAME
    if not path.exists():
        return None
    try:
        data = json.loads(path.read_text())
    except (OSError, ValueError) as error:
        raise ManagedFilesError(f"{path} is unreadable: {error}") from error
    if not isinstance(data, dict) or data.get("version") != MANIFEST_VERSION:
        raise ManagedFilesError(f"{path} is not a version {MANIFEST_VERSION} manifest")
    files = data.get("files")
    if not isinstance(files, list) or not all(isinstance(f, str) for f in files):
        raise ManagedFilesError(f"{path} has no list of file names")
    unsafe = sorted(f for f in files if not is_safe(f))
    if unsafe:
        raise ManagedFilesError(
            f"{path} lists paths outside the world directory: {unsafe[:5]}"
        )
    return set(files)


def write_manifest(world: Path, files: set[str]) -> None:
    """Record `files` atomically, so a crash never leaves a half-written manifest."""
    path = world / MANIFEST_NAME
    tmp = path.with_name(path.name + ".tmp")
    tmp.write_text(
        json.dumps({"version": MANIFEST_VERSION, "files": sorted(files)}, indent=1)
    )
    tmp.replace(path)


def retire(world: Path, dropped: Iterable[str], stamp: str) -> list[str]:
    """Move the dropped files that still exist into .erisia-removed/<stamp>/. Returns those moved.

    Directories and files that are already gone are skipped. A failed move raises
    ManagedFilesError; the files moved before it stay moved, and the next start retries the rest.
    """
    moved = []
    for rel in sorted(dropped):
        if not is_safe(rel):
            raise ManagedFilesError(
                f"refusing to retire {rel!r}: outside the world directory"
            )
        source = world / rel
        if not (source.is_file() or source.is_symlink()):
            continue
        target = world / REMOVED_DIR_NAME / stamp / rel
        try:
            target.parent.mkdir(parents=True, exist_ok=True)
            shutil.move(str(source), str(target))
        except OSError as error:
            raise ManagedFilesError(
                f"couldn't move {rel} to {target}: {error}"
            ) from error
        moved.append(rel)
    return moved


def update(
    base: Path, world: Path, dirs: Iterable[str], stamp: str, log: Callable[[str], None]
) -> list[str]:
    """After syncing `dirs` from `base` into `world`: retire dropped files, record the new set.

    Returns the retired paths. Raises ManagedFilesError (see the module docs); the manifest is
    then left as it was, for inspection.
    """
    current = shipped_files(base, dirs)
    previous = read_manifest(world)
    if previous is None:
        moved = []
    else:
        moved = retire(world, previous - current, stamp)
        for rel in moved:
            log(f"retired {rel} (dropped from the pack) to {REMOVED_DIR_NAME}/{stamp}/")
    write_manifest(world, current)
    return moved
