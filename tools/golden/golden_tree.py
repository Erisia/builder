"""List every file in some build outputs, with its mode, size and sha256, as stable text.

The output is a "golden tree". It is committed as tests/golden/<pack>.tree, and
`nix flake check` compares a fresh one against it (lib/golden.nix). So any change to what the
server or the players receive shows up as a diff in review, and a refactor that should change
nothing can be shown to change nothing.

Usage: golden_tree.py NAME=PATH [NAME=PATH ...]

Each PATH is a file or directory, usually a store path. Symlinks are followed (store outputs
are mostly symlink farms, and what matters is the content they reach). Each output line is

    NAME/relative/path<TAB>MODE<TAB>SIZE<TAB>SHA256

where MODE is "x" for an executable file and "f" otherwise. A symlink that resolves to
nothing gives a line with MODE "broken" and its target in place of the size and hash. Lines
are sorted, so the order of the filesystem doesn't matter.
"""

from __future__ import annotations

import hashlib
import os
import stat
import sys
from collections.abc import Iterator
from pathlib import Path


def sha256_file(path: Path) -> str:
    digest = hashlib.sha256()
    with path.open("rb") as handle:
        for block in iter(lambda: handle.read(1 << 20), b""):
            digest.update(block)
    return digest.hexdigest()


def file_line(label: str, path: Path) -> str:
    """One line for a single path, following symlinks."""
    try:
        info = path.stat()
    except FileNotFoundError:
        return f"{label}\tbroken\t->\t{os.readlink(path)}"
    mode = "x" if info.st_mode & stat.S_IXUSR else "f"
    return f"{label}\t{mode}\t{info.st_size}\t{sha256_file(path)}"


def walk(name: str, root: Path) -> Iterator[str]:
    """Lines for every file under root (or for root itself, if it is a file)."""
    if not root.is_dir():
        yield file_line(name, root)
        return
    for directory, _dirnames, filenames in os.walk(root, followlinks=True):
        base = Path(directory)
        rel = base.relative_to(root)
        # os.walk lists dangling symlinks under filenames, so they reach file_line.
        for entry in filenames:
            yield file_line(f"{name}/{(rel / entry).as_posix()}", base / entry)


def golden_tree(roots: dict[str, Path]) -> list[str]:
    lines: list[str] = []
    for name, root in roots.items():
        lines.extend(walk(name, root))
    return sorted(lines)


def parse_args(argv: list[str]) -> dict[str, Path]:
    roots: dict[str, Path] = {}
    for arg in argv:
        name, sep, path = arg.partition("=")
        if not sep or not name or not path:
            raise SystemExit(f"expected NAME=PATH, got {arg!r}")
        if name in roots:
            raise SystemExit(f"duplicate name {name!r}")
        roots[name] = Path(path)
    if not roots:
        raise SystemExit(__doc__)
    return roots


def main(argv: list[str]) -> None:
    for line in golden_tree(parse_args(argv)):
        print(line)


if __name__ == "__main__":
    main(sys.argv[1:])
