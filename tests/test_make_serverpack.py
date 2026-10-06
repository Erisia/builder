"""Unit tests for lib/make-serverpack.py."""

from __future__ import annotations

import copy
import importlib.util
import sys
import tempfile
import unittest
import zipfile
from pathlib import Path
from typing import Any
from xml.etree import ElementTree

ROOT = Path(__file__).resolve().parents[1]
spec = importlib.util.spec_from_file_location(
    "make_serverpack", ROOT / "lib/make-serverpack.py"
)
assert spec is not None and spec.loader is not None
msp = importlib.util.module_from_spec(spec)
# dataclasses look the module up by name while the file is executed.
sys.modules["make_serverpack"] = msp
spec.loader.exec_module(msp)

NS = {"m": "http://www.mcupdater.com"}


def mod(name: str, filename: str, md5: str = "aa") -> dict[str, Any]:
    return {
        "name": name,
        "title": name.title(),
        "side": "both",
        "required": True,
        "default": True,
        "filename": filename,
        "encoded": filename.replace(" ", "%20"),
        "src": f"https://example.invalid/{filename}",
        "size": 3,
        "md5": md5,
        "sha256": "00",
    }


class ServerPackTests(unittest.TestCase):
    def setUp(self) -> None:
        self.tmp = Path(self.enterContext(tempfile.TemporaryDirectory()))
        self.inputs = self.tmp / "inputs"
        self.inputs.mkdir()
        (self.inputs / "index.html").write_text("<html/>")
        with zipfile.ZipFile(self.inputs / "MCUpdater-Bootstrap.jar", "w") as z:
            z.writestr("Main.class", b"\xca\xfe")

    def configs_dir(self, name: str, configs: dict[str, str]) -> Path:
        """A fake mkZipDirs output: <dir>.zip/.md5/.size for each config dir."""
        path = self.tmp / name
        path.mkdir()
        for config, md5 in configs.items():
            (path / f"{config}.zip").write_bytes(b"zip")
            (path / f"{config}.md5").write_text(md5)
            (path / f"{config}.size").write_text("3\n")
        return path

    def descriptor(
        self, configs_dir: Path, mods: list[dict[str, Any]]
    ) -> dict[str, Any]:
        mods_dir = self.tmp / f"mods-{configs_dir.name}"
        mods_dir.mkdir(exist_ok=True)
        for m in mods:
            (mods_dir / m["filename"]).write_bytes(b"jar")
        return {
            "description": "E36: test",
            "minecraft": "1.12.2",
            "port": 25565,
            "loader": {
                "type": "Forge",
                "version": "1.12.2-14.23.5.2864",
                "mainClass": "net.minecraft.launchwrapper.Launch",
            },
            "mods": mods,
            "modsDir": str(mods_dir),
            "configsDir": str(configs_dir),
        }

    def build(self, packs: dict[str, Any], name: str = "out") -> Path:
        out = self.tmp / name
        msp.create_server_pack(
            packs, "minecraft.example:1234", "https://pack.example/", out, self.inputs
        )
        return out

    def test_layout_and_xml(self) -> None:
        pack = self.descriptor(
            self.configs_dir("cfg", {"config": "c1", "mods": "m1"}),
            [
                mod("jei", "jei.jar"),
                mod("jei", "jei extra.jar"),
                mod("ae2", "ae2.jar"),
                mod("config", "configmod.jar"),
            ],
        )
        out = self.build({"e36": pack})

        self.assertEqual((out / "index.html").read_text(), "<html/>")
        self.assertEqual(
            (out / "packs/e36/mods/ae2.jar").resolve(),
            Path(pack["modsDir"]) / "ae2.jar",
        )
        self.assertTrue((out / "packs/e36/configs/config.zip").is_symlink())
        with zipfile.ZipFile(out / "MCUpdater-Bootstrap.jar") as z:
            self.assertIn(
                "defaultPack = https://pack.example/ServerPack.xml",
                z.read("config.properties").decode(),
            )
            self.assertEqual(z.read("Main.class"), b"\xca\xfe")

        root = ElementTree.parse(out / "ServerPack.xml").getroot()
        server = root.find("m:Server", NS)
        assert server is not None
        self.assertEqual(server.get("id"), "e36")
        self.assertEqual(server.get("serverAddress"), "minecraft.example:25565")
        self.assertEqual(server.get("mainClass"), "net.minecraft.launchwrapper.Launch")
        self.assertEqual(server.get("autoConnect"), "false")
        loader = server.find("m:Loader", NS)
        assert loader is not None
        self.assertEqual(loader.get("version"), "1.12.2-14.23.5.2864")
        modules = {m.get("id"): m for m in server.findall("m:Module", NS)}
        # Repeated ids get numbers (mods first, then configs); modules are sorted by id.
        self.assertEqual(
            list(modules), ["ae2", "config", "config-1", "jei", "jei-1", "mods"]
        )
        config_zip = modules["config-1"]
        self.assertEqual(config_zip.findtext("m:ModType", namespaces=NS), "Extract")
        self.assertEqual(config_zip.findtext("m:MD5", namespaces=NS), "c1")
        self.assertEqual(
            config_zip.findtext("m:URL", namespaces=NS),
            "https://pack.example/packs/e36/configs/config.zip",
        )
        self.assertEqual(
            modules["jei-1"].findtext("m:URL", namespaces=NS),
            "https://pack.example/packs/e36/mods/jei%20extra.jar",
        )

    def revision_of(self, pack: dict[str, Any]) -> str:
        configs = msp.read_config_zips(Path(pack["configsDir"]))
        result: str = msp.revision(pack, configs)
        return result

    def test_revision_ignores_store_paths_but_tracks_content(self) -> None:
        mods = [mod("jei", "jei.jar")]
        base = self.descriptor(self.configs_dir("a", {"config": "c1"}), mods)
        # Same content in different store paths: no update prompt.
        moved = self.descriptor(self.configs_dir("b", {"config": "c1"}), mods)
        self.assertEqual(self.revision_of(base), self.revision_of(moved))
        # A changed config zip, mod or loader: a new revision.
        changed_config = self.descriptor(self.configs_dir("c", {"config": "c2"}), mods)
        self.assertNotEqual(self.revision_of(base), self.revision_of(changed_config))
        changed_mod = copy.deepcopy(base)
        changed_mod["mods"][0]["md5"] = "bb"
        self.assertNotEqual(self.revision_of(base), self.revision_of(changed_mod))
        changed_loader = copy.deepcopy(base)
        changed_loader["loader"]["version"] = "1.12.2-14.23.5.2860"
        self.assertNotEqual(self.revision_of(base), self.revision_of(changed_loader))

    def test_main_rejects_wrong_arguments(self) -> None:
        with self.assertRaises(SystemExit):
            msp.main(["only-one"])


if __name__ == "__main__":
    unittest.main()
