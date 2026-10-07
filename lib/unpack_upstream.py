"""Unpack an upstream CurseForge pack's overrides and lay the pack's overlay on top.

Produces two trees: `common` (both sides) and `client` (the upstream top-level directories named
with --client-only, plus overlay/client). The server-only overlay isn't handled here; lib/pack.nix
adds overlay/server to the server's directories as it is.

Upstream files are taken from `overrides/` in the zip, minus the tombstone list (one path per
line; blank lines and `#` comments are ignored). Files whose suffix is in --text-suffix have
CRLF line endings converted to LF; everything else is copied byte for byte.

It fails, rather than guessing, when:
- a tombstone names a file the zip doesn't have (a stale entry after an upstream update),
- a path is both tombstoned and in the overlay,
- an overlay file is identical to the upstream file it replaces (a dead edit),
- a zip entry would escape the output directory.

Consumers: lib/upstream.nix. Tests: tests/test_unpack_upstream.py.
"""

from __future__ import annotations

import argparse
import sys
import zipfile
from pathlib import Path, PurePosixPath

OVERRIDES = "overrides/"


class UpstreamError(Exception):
    """The upstream zip, the tombstones and the overlay don't fit together."""


def read_tombstones(path: Path) -> set[str]:
    """The paths listed in a tombstone file, relative to `overrides/`."""
    entries = set()
    for line in path.read_text().splitlines():
        line = line.strip()
        if line and not line.startswith("#"):
            entries.add(line)
    return entries


def safe_relative(name: str) -> str:
    """`name` as a relative path, or an error if it would leave the output directory."""
    path = PurePosixPath(name)
    if path.is_absolute() or ".." in path.parts or not path.parts:
        raise UpstreamError(f"unsafe path in zip: {name!r}")
    return str(path)


def normalise(rel: str, data: bytes, text_suffixes: set[str]) -> bytes:
    """CRLF to LF for text files (by suffix, case-insensitively); other files unchanged."""
    if PurePosixPath(rel).suffix.lower() in text_suffixes:
        return data.replace(b"\r\n", b"\n")
    return data


def upstream_files(
    zip_path: Path, tombstones: set[str], text_suffixes: set[str]
) -> dict[str, bytes]:
    """The kept override files, normalised, keyed by path relative to `overrides/`."""
    files: dict[str, bytes] = {}
    with zipfile.ZipFile(zip_path) as archive:
        for info in archive.infolist():
            if info.is_dir() or not info.filename.startswith(OVERRIDES):
                continue
            rel = safe_relative(info.filename[len(OVERRIDES) :])
            files[rel] = normalise(rel, archive.read(info), text_suffixes)
    stale = sorted(tombstones - files.keys())
    if stale:
        raise UpstreamError(f"tombstones for files the zip doesn't have: {stale}")
    return {rel: data for rel, data in files.items() if rel not in tombstones}


def overlay_files(root: Path) -> dict[str, Path]:
    """Every file under `root`, keyed by relative path. A missing root is empty."""
    if not root.is_dir():
        return {}
    return {
        str(path.relative_to(root)): path
        for path in sorted(root.rglob("*"))
        if path.is_file()
    }


def side_of(rel: str, client_only: set[str]) -> str:
    """Which tree an upstream file belongs in."""
    return "client" if PurePosixPath(rel).parts[0] in client_only else "common"


def build(
    zip_path: Path,
    tombstone_path: Path,
    overlay: Path,
    client_only: set[str],
    text_suffixes: set[str],
    outputs: dict[str, Path],
) -> None:
    """Write the `common` and `client` trees into `outputs`."""
    tombstones = read_tombstones(tombstone_path)
    upstream = upstream_files(zip_path, tombstones, text_suffixes)
    trees: dict[str, dict[str, bytes]] = {"common": {}, "client": {}}
    for rel, data in upstream.items():
        trees[side_of(rel, client_only)][rel] = data

    for side, tree in trees.items():
        for rel, source in overlay_files(overlay / side).items():
            if rel in tombstones:
                raise UpstreamError(
                    f"{side}/{rel} is both tombstoned and in the overlay"
                )
            data = source.read_bytes()
            if upstream.get(rel) == data:
                raise UpstreamError(
                    f"overlay {side}/{rel} is identical to upstream; delete it"
                )
            tree[rel] = data

    for side, tree in trees.items():
        out = outputs[side]
        out.mkdir(parents=True, exist_ok=True)
        for rel, data in sorted(tree.items()):
            target = out / rel
            target.parent.mkdir(parents=True, exist_ok=True)
            target.write_bytes(data)
            target.chmod(0o644)


def main(argv: list[str]) -> int:
    parser = argparse.ArgumentParser(description=__doc__.splitlines()[0])
    parser.add_argument("--zip", type=Path, required=True)
    parser.add_argument(
        "--removed", type=Path, required=True, help="the tombstone list"
    )
    parser.add_argument(
        "--overlay", type=Path, required=True, help="has common/ and client/"
    )
    parser.add_argument("--client-only", action="append", default=[], metavar="DIR")
    parser.add_argument("--text-suffix", action="append", default=[], metavar=".EXT")
    parser.add_argument("--common", type=Path, required=True, help="output: both sides")
    parser.add_argument(
        "--client", type=Path, required=True, help="output: clients only"
    )
    args = parser.parse_args(argv)
    try:
        build(
            args.zip,
            args.removed,
            args.overlay,
            set(args.client_only),
            {suffix.lower() for suffix in args.text_suffix},
            {"common": args.common, "client": args.client},
        )
    except UpstreamError as error:
        print(f"unpack_upstream: {error}", file=sys.stderr)
        return 1
    return 0


if __name__ == "__main__":
    sys.exit(main(sys.argv[1:]))
