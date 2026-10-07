"""Generate a pack's Prism outputs: a packwiz index for packwiz-installer, and the Prism instance zip.

The packwiz pack (served at <base-url>pack.toml) lists every client file with its sha256:
- each manifest mod as a metafile `mods/<name>.pw.toml` holding its download URL, side and, for
  optional mods, an `[option]` table. Metafile paths are keyed by the mod's manifest name, so they
  stay stable across updates (packwiz-installer tracks files by index path);
- every file of the client config tree (the same tree MCUpdater's config zips carry) as a plain
  entry, copied next to pack.toml.
pack.toml lists only `minecraft` under `[versions]`: with a loader key, packwiz-installer would
rewrite the instance's mmc-pack.json. The output is deterministic, so an unchanged pack gives a
byte-identical pack.toml, and a launch with nothing to update costs one small request.

The instance zip holds instance.cfg, mmc-pack.json, the icon and packwiz-installer.jar (in
`minecraft/`, the game directory, where the pre-launch command runs). The pre-launch command runs
the installer's Main class directly, never packwiz-installer-bootstrap, whose self-update would
fetch an unchecked jar from GitHub.

Consumers: lib/prism.nix. Tests: tests/test_make_packwiz.py.
"""

from __future__ import annotations

import argparse
import hashlib
import json
import shutil
import sys
import zipfile
from dataclasses import dataclass
from pathlib import Path, PurePosixPath
from typing import Any

PACK_FORMAT = "packwiz:1.1.0"
INSTALLER_MAIN = "link.infra.packwiz.installer.Main"
# Fixed zip timestamps keep the instance zip byte-identical between builds.
ZIP_DATE = (1980, 1, 1, 0, 0, 0)


class PackwizError(Exception):
    """The inputs can't be turned into a consistent pack."""


@dataclass(frozen=True)
class Mod:
    """One manifest entry, as lib/pack.nix's client descriptor lists it."""

    name: str
    title: str
    side: str
    required: bool
    default: bool
    filename: str
    src: str
    sha256: str

    @staticmethod
    def from_json(entry: dict[str, Any]) -> Mod:
        side = entry["side"]
        if side not in ("both", "client"):
            raise PackwizError(
                f"mod {entry['name']!r} has side {side!r}; clients get both/client"
            )
        return Mod(
            name=entry["name"],
            title=entry.get("title") or entry["name"],
            side=side,
            required=bool(entry["required"]),
            default=bool(entry["default"]),
            filename=entry["filename"],
            src=entry["src"],
            sha256=entry["sha256"].lower(),
        )


def toml_string(value: str) -> str:
    """A TOML basic string."""
    out = ['"']
    for char in value:
        if char in ('"', "\\"):
            out.append("\\" + char)
        elif ord(char) < 0x20 or ord(char) == 0x7F:
            out.append(f"\\u{ord(char):04x}")
        else:
            out.append(char)
    out.append('"')
    return "".join(out)


def sha256(data: bytes) -> str:
    return hashlib.sha256(data).hexdigest()


def check_path(rel: str) -> str:
    """`rel` if it's a clean relative POSIX path; packwiz paths are relative to pack.toml."""
    path = PurePosixPath(rel)
    if (
        path.is_absolute()
        or not path.parts
        or ".." in path.parts
        or "\\" in rel
        or ":" in rel
    ):
        raise PackwizError(f"unsafe path: {rel!r}")
    return str(path)


def metafile(mod: Mod) -> bytes:
    """The `.pw.toml` for one mod."""
    lines = [
        f"name = {toml_string(mod.title)}",
        f"filename = {toml_string(mod.filename)}",
        f"side = {toml_string(mod.side)}",
        "",
        "[download]",
        f"url = {toml_string(mod.src)}",
        'hash-format = "sha256"',
        f"hash = {toml_string(mod.sha256)}",
    ]
    if not mod.required:
        lines += [
            "",
            "[option]",
            "optional = true",
            f"default = {'true' if mod.default else 'false'}",
        ]
    return ("\n".join(lines) + "\n").encode()


def tree_files(tree: Path) -> dict[str, Path]:
    """Every file under `tree` (following symlinks), keyed by relative POSIX path."""
    files = {}
    for path in sorted(tree.rglob("*")):
        if path.is_file():
            files[check_path(path.relative_to(tree).as_posix())] = path
    return files


def build_pack(
    name: str,
    minecraft: str,
    mods: list[Mod],
    tree: Path,
    preserve: set[str],
    out: Path,
) -> str:
    """Write the packwiz pack into `out`. Returns pack.toml's sha256."""
    entries: dict[str, tuple[str, bool]] = {}  # index path -> (sha256, is metafile)
    installed: dict[
        str, str
    ] = {}  # where each entry ends up -> index path, to catch clashes

    def claim(target: str, source: str) -> None:
        if target in installed:
            raise PackwizError(
                f"{source} and {installed[target]} both install {target}"
            )
        installed[target] = source

    for mod in sorted(mods, key=lambda m: m.name):
        rel = check_path(f"mods/{mod.name}.pw.toml")
        claim(check_path(f"mods/{mod.filename}"), rel)
        data = metafile(mod)
        write(out / rel, data)
        entries[rel] = (sha256(data), True)

    for rel, source in tree_files(tree).items():
        if rel in ("pack.toml", "index.toml"):
            raise PackwizError(
                f"the client tree has {rel}, which the pack needs for itself"
            )
        claim(rel, rel)
        data = source.read_bytes()
        write(out / rel, data)
        entries[rel] = (sha256(data), False)

    unknown = sorted(preserve - entries.keys())
    if unknown:
        raise PackwizError(f"preserve lists files the pack doesn't have: {unknown}")

    index = ['hash-format = "sha256"']
    for rel in sorted(entries):
        digest, is_meta = entries[rel]
        index += [
            "",
            "[[files]]",
            f"file = {toml_string(rel)}",
            f"hash = {toml_string(digest)}",
        ]
        if is_meta:
            index.append("metafile = true")
        if rel in preserve:
            index.append("preserve = true")
    index_bytes = ("\n".join(index) + "\n").encode()
    write(out / "index.toml", index_bytes)

    index_hash = sha256(index_bytes)
    pack = [
        f"name = {toml_string(name)}",
        # Shown by packwiz-installer; derived from the content, so it changes exactly when the pack does.
        f"version = {toml_string(index_hash[:12])}",
        f"pack-format = {toml_string(PACK_FORMAT)}",
        "",
        "[index]",
        'file = "index.toml"',
        'hash-format = "sha256"',
        f"hash = {toml_string(index_hash)}",
        "",
        "[versions]",
        f"minecraft = {toml_string(minecraft)}",
    ]
    pack_bytes = ("\n".join(pack) + "\n").encode()
    write(out / "pack.toml", pack_bytes)
    return sha256(pack_bytes)


def write(path: Path, data: bytes) -> None:
    path.parent.mkdir(parents=True, exist_ok=True)
    path.write_bytes(data)
    path.chmod(0o644)


def instance_cfg(name: str, pack_url: str, max_mem: int, min_mem: int) -> bytes:
    """instance.cfg in the legacy MultiMC form, which Prism reads and migrates.

    The legacy parser treats `#` as a comment, and strips surrounding quotes from values that
    contain `;`, `=` or `,`; none of those may appear in the command.
    """
    if not name.replace("-", "").replace("_", "").isalnum():
        raise PackwizError(
            f"instance name {name!r} must be letters, digits, - and _ (it's a command argument)"
        )
    command = f'"$INST_JAVA" -cp packwiz-installer.jar {INSTALLER_MAIN} --title {name} {pack_url}'
    for bad in "#;=,\n":
        if bad in command:
            raise PackwizError(f"pre-launch command can't contain {bad!r}: {command}")
    lines = [
        "InstanceType=OneSix",
        f"name={name}",
        f"iconKey={name.lower()}",
        "notes=Mods and configs are synced from the Erisia server on every launch.",
        "OverrideCommands=true",
        f"PreLaunchCommand={command}",
        "OverrideMemory=true",
        f"MinMemAlloc={min_mem}",
        f"MaxMemAlloc={max_mem}",
    ]
    return ("\n".join(lines) + "\n").encode()


def mmc_pack(minecraft: str, forge: str) -> bytes:
    """The instance's components; Prism fills in the rest (LWJGL, cached names) on first load."""
    data = {
        "formatVersion": 1,
        "components": [
            {"uid": "net.minecraft", "version": minecraft, "important": True},
            {"uid": "net.minecraftforge", "version": forge},
        ],
    }
    return (json.dumps(data, indent=2) + "\n").encode()


def build_instance(
    name: str,
    minecraft: str,
    forge: str,
    pack_url: str,
    installer: Path,
    icon: Path,
    max_mem: int,
    min_mem: int,
    out: Path,
) -> None:
    """Write the Prism instance zip to `out`."""
    members = [
        ("instance.cfg", instance_cfg(name, pack_url, max_mem, min_mem)),
        ("mmc-pack.json", mmc_pack(minecraft, forge)),
        (f"{name.lower()}{icon.suffix}", icon.read_bytes()),
        ("minecraft/packwiz-installer.jar", installer.read_bytes()),
    ]
    out.parent.mkdir(parents=True, exist_ok=True)
    with zipfile.ZipFile(out, "w", compression=zipfile.ZIP_DEFLATED) as archive:
        for member, data in members:
            info = zipfile.ZipInfo(member, date_time=ZIP_DATE)
            info.external_attr = 0o644 << 16
            info.compress_type = zipfile.ZIP_DEFLATED
            archive.writestr(info, data)
    out.chmod(0o644)


def main(argv: list[str]) -> int:
    parser = argparse.ArgumentParser(description=__doc__.splitlines()[0])
    parser.add_argument(
        "--name", required=True, help="pack and instance name, e.g. E36"
    )
    parser.add_argument("--minecraft", required=True)
    parser.add_argument(
        "--forge", required=True, help="the clients' Forge version, e.g. 14.23.5.2864"
    )
    parser.add_argument(
        "--mods", type=Path, required=True, help="JSON list of client manifest entries"
    )
    parser.add_argument(
        "--tree", type=Path, required=True, help="the client config tree"
    )
    parser.add_argument("--preserve", action="append", default=[], metavar="PATH")
    parser.add_argument(
        "--base-url", required=True, help="where the pack is served, ending in /"
    )
    parser.add_argument(
        "--installer", type=Path, required=True, help="packwiz-installer.jar"
    )
    parser.add_argument("--icon", type=Path, required=True)
    parser.add_argument("--max-mem", type=int, default=6144, help="MiB")
    parser.add_argument("--min-mem", type=int, default=2048, help="MiB")
    parser.add_argument("--out", type=Path, required=True)
    args = parser.parse_args(argv)
    if not args.base_url.endswith("/"):
        parser.error("--base-url must end in /")
    try:
        mods = [Mod.from_json(entry) for entry in json.loads(args.mods.read_text())]
        if args.out.exists():
            shutil.rmtree(args.out)
        build_pack(
            args.name,
            args.minecraft,
            mods,
            args.tree,
            set(args.preserve),
            args.out / "pack",
        )
        build_instance(
            args.name,
            args.minecraft,
            args.forge,
            args.base_url + "pack/pack.toml",
            args.installer,
            args.icon,
            args.max_mem,
            args.min_mem,
            args.out / f"{args.name}.zip",
        )
    except PackwizError as error:
        print(f"make_packwiz: {error}", file=sys.stderr)
        return 1
    return 0


if __name__ == "__main__":
    sys.exit(main(sys.argv[1:]))
