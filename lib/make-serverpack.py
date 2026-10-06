"""Build the MCUpdater ServerPack directory that clients download from.

Usage: make-serverpack.py PACKS_JSON HOSTNAME URL_BASE OUTPUT

Run by buildServerPack (lib/lib.nix), in a directory that holds index.html and
MCUpdater-Bootstrap.jar. PACKS_JSON maps each pack id (for example "e36", which is also
the MCUpdater instance folder) to that pack's `client` descriptor from buildPack:

    {"description": str, "minecraft": str, "port": int,
     "loader": {"type": str, "version": str, "mainClass": str},
     "mods": [manifest entry, ...],   # entries of manifest/<pack>.json for the client
     "modsDir": store path,           # <filename> for every mod
     "configsDir": store path}        # <dir>.zip, <dir>.md5 and <dir>.size per config dir

OUTPUT then gets:
    index.html, MCUpdater-Bootstrap.jar (with defaultPack pointing at this ServerPack),
    ServerPack.xml, and packs/<id>/mods/<filename> and packs/<id>/configs/<dir>.zip,
    which are symlinks into the store.

The paths under packs/ and the module ids are interface: players' MCUpdater installs
refer to them. See ~/agent/work/builder-arch/runtime-interface.md (C1-C10).
"""

from __future__ import annotations

import hashlib
import json
import os
import shutil
import sys
import zipfile
from dataclasses import dataclass, field
from pathlib import Path
from typing import Any
from xml.dom import minidom
from xml.etree.ElementTree import Element, SubElement, tostring

# One manifest entry: {name, title, side, required, default, filename, encoded, src, size, md5, sha256}.
ModEntry = dict[str, Any]
Descriptor = dict[str, Any]


# These types correspond to the ServerPack.xml file.


@dataclass
class URL:
    link: str
    priority: int


@dataclass
class Module:
    name: str
    id: str
    urls: list[URL]
    mod_path: str
    size: int
    required: bool
    mod_type: str
    md5: str
    default: bool = True
    load_prefix: str | None = None
    in_root: bool = False


@dataclass
class Loader:
    type: str
    version: str
    load_order: int


@dataclass
class Server:
    id: str
    name: str
    version: str
    news_url: str | None = None
    icon_url: str | None = None
    revision: str | None = None
    main_class: str | None = None
    server_address: str | None = None
    auto_connect: bool = True
    loader: Loader | None = None
    modules: list[Module] = field(default_factory=list)


@dataclass
class ConfigZip:
    """One config dir, zipped by mkZipDirs."""

    name: str
    zip_path: Path
    md5: str
    size: int


def read_config_zips(configs_dir: Path) -> list[ConfigZip]:
    """The config zips in a mkZipDirs output, sorted by name."""
    zips = []
    for zip_path in sorted(configs_dir.glob("*.zip")):
        name = zip_path.name.removesuffix(".zip")
        md5 = (configs_dir / f"{name}.md5").read_text().strip()
        size = int((configs_dir / f"{name}.size").read_text().strip())
        zips.append(ConfigZip(name=name, zip_path=zip_path, md5=md5, size=size))
    return zips


def revision(pack: Descriptor, configs: list[ConfigZip]) -> str:
    """A hash of everything MCUpdater installs for this pack.

    It changes exactly when a client would get something different, which is what makes
    MCUpdater offer an update. Store paths are left out on purpose: they also change for
    server-only or toolchain changes, and those must not prompt players.
    """
    content = {
        "description": pack["description"],
        "minecraft": pack["minecraft"],
        "port": pack["port"],
        "loader": pack["loader"],
        "mods": pack["mods"],
        "configs": {c.name: c.md5 for c in configs},
    }
    return hashlib.sha256(
        json.dumps(content, sort_keys=True).encode("utf-8")
    ).hexdigest()


def unique_id(base: str, taken: dict[str, Module]) -> str:
    """MCUpdater quietly fails on duplicate module ids, so number the repeats."""
    candidate, iteration = base, 1
    while candidate in taken:
        candidate = f"{base}-{iteration}"
        iteration += 1
    return candidate


def make_server(
    pack_id: str,
    pack: Descriptor,
    configs: list[ConfigZip],
    hostname: str,
    url_base: str,
) -> Server:
    modules: dict[str, Module] = {}
    for mod in pack["mods"]:
        mod_id = unique_id(mod["name"], modules)
        modules[mod_id] = Module(
            name=mod["title"],
            id=mod_id,
            urls=[
                URL(link=f"{url_base}packs/{pack_id}/mods/{mod['encoded']}", priority=0)
            ],
            mod_path=f"mods/{mod['filename']}",
            size=mod["size"],
            required=mod["required"],
            default=mod["default"],
            mod_type="Regular",
            md5=mod["md5"],
        )
    for config in configs:
        config_id = unique_id(config.name, modules)
        modules[config_id] = Module(
            name=f"Config ({config.name})",
            id=config_id,
            urls=[
                URL(
                    link=f"{url_base}packs/{pack_id}/configs/{config.name}.zip",
                    priority=0,
                )
            ],
            mod_path="config",
            size=config.size,
            required=True,
            mod_type="Extract",
            in_root=True,
            md5=config.md5,
        )

    loader = pack["loader"]
    return Server(
        id=pack_id,
        name=pack["description"],
        version=pack["minecraft"],
        news_url="https://madoka.brage.info/",
        revision=revision(pack, configs),
        server_address=f"{hostname.split(':')[0]}:{pack['port']}",
        auto_connect=False,
        loader=Loader(type=loader["type"], version=loader["version"], load_order=0),
        modules=sorted(modules.values(), key=lambda m: m.id),
        main_class=loader["mainClass"],
    )


def server_pack_xml(servers: list[Server]) -> str:
    root = Element("ServerPack", version="3.3")
    root.attrib["xmlns"] = "http://www.mcupdater.com"
    root.attrib["xmlns:xsi"] = "http://www.w3.org/2001/XMLSchema-instance"
    root.attrib["xsi:schemaLocation"] = (
        "http://www.mcupdater.com http://files.mcupdater.com/ServerPackv2.xsd"
    )

    for server in servers:
        elem = SubElement(
            root, "Server", id=server.id, name=server.name, version=server.version
        )
        if server.news_url:
            elem.set("newsUrl", server.news_url)
        if server.icon_url:
            elem.set("iconUrl", server.icon_url)
        if server.revision:
            elem.set("revision", server.revision)
        if server.main_class:
            elem.set("mainClass", server.main_class)
        if server.server_address:
            elem.set("serverAddress", server.server_address)
        elem.set("autoConnect", "true" if server.auto_connect else "false")
        if server.loader:
            SubElement(
                elem,
                "Loader",
                type=server.loader.type,
                version=server.loader.version,
                loadOrder=str(server.loader.load_order),
            )
        for module in server.modules:
            type_attrib = {"inRoot": "true"} if module.in_root else {}
            module_elem = SubElement(elem, "Module", name=module.name, id=module.id)
            for url in module.urls:
                SubElement(
                    module_elem, "URL", priority=str(url.priority)
                ).text = url.link
            SubElement(module_elem, "LoadPrefix").text = module.load_prefix
            SubElement(module_elem, "ModPath").text = module.mod_path
            SubElement(module_elem, "Size").text = str(module.size)
            SubElement(
                module_elem, "Required", isDefault=str(module.default)
            ).text = str(module.required)
            SubElement(
                module_elem, "ModType", attrib=type_attrib
            ).text = module.mod_type
            SubElement(module_elem, "MD5").text = module.md5

    return minidom.parseString(tostring(root, encoding="utf-8")).toprettyxml(
        indent="    "
    )


def link_pack_files(
    pack_id: str, pack: Descriptor, configs: list[ConfigZip], packs_path: Path
) -> None:
    """packs/<id>/mods/<filename> and packs/<id>/configs/<dir>.zip, as store symlinks."""
    mods_dir = packs_path / pack_id / "mods"
    configs_dir = packs_path / pack_id / "configs"
    mods_dir.mkdir(parents=True)
    configs_dir.mkdir()
    for config in configs:
        (configs_dir / f"{config.name}.zip").symlink_to(config.zip_path)
    for mod in pack["mods"]:
        (mods_dir / mod["filename"]).symlink_to(Path(pack["modsDir"]) / mod["filename"])


def make_bootstrap(base_jar: Path, url_base: str, output: Path) -> None:
    """Copy the bootstrap jar, adding a config.properties that points at this ServerPack."""
    with zipfile.ZipFile(base_jar, "r") as z:
        files = {info.filename: z.read(info.filename) for info in z.infolist()}

    properties = f"""\
bootstrapURL = https://files.mcupdater.com/Bootstrap.xml
distribution = JavaFX-Release
defaultPack = {url_base}ServerPack.xml
customPath =
passthroughArgs = -defaultMem 6G
    """
    files["config.properties"] = properties.encode("utf-8")

    with zipfile.ZipFile(output, "x") as z:
        for filename, data in files.items():
            z.writestr(filename, data)


def create_server_pack(
    packs: dict[str, Descriptor],
    hostname: str,
    url_base: str,
    output: Path,
    inputs: Path,
) -> None:
    """Write the whole ServerPack directory. `inputs` holds index.html and the bootstrap jar."""
    output.mkdir()
    shutil.copy(inputs / "index.html", output)
    make_bootstrap(
        inputs / "MCUpdater-Bootstrap.jar", url_base, output / "MCUpdater-Bootstrap.jar"
    )

    servers = []
    (output / "packs").mkdir()
    for pack_id, pack in packs.items():
        configs = read_config_zips(Path(pack["configsDir"]))
        link_pack_files(pack_id, pack, configs, output / "packs")
        servers.append(make_server(pack_id, pack, configs, hostname, url_base))
    (output / "ServerPack.xml").write_text(server_pack_xml(servers))


def main(argv: list[str]) -> None:
    if len(argv) != 4:
        raise SystemExit(__doc__)
    packs_json, hostname, url_base, output = argv
    packs = json.loads(Path(packs_json).read_text())
    create_server_pack(packs, hostname, url_base, Path(output), Path(os.getcwd()))


if __name__ == "__main__":
    main(sys.argv[1:])
