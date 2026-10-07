"""lib/make_packwiz.py: the packwiz index, metafiles and the Prism instance zip."""

from __future__ import annotations

import hashlib
import importlib.util
import json
import sys
import tempfile
import unittest
import zipfile
from pathlib import Path
from types import ModuleType
from typing import Any

import tomllib

ROOT = Path(__file__).resolve().parents[1]


def load_tool() -> ModuleType:
    """lib/ isn't a package, so load the module by location."""
    spec = importlib.util.spec_from_file_location(
        "make_packwiz", ROOT / "lib/make_packwiz.py"
    )
    assert spec is not None and spec.loader is not None
    module = importlib.util.module_from_spec(spec)
    sys.modules[spec.name] = module  # dataclasses look their module up there
    spec.loader.exec_module(module)
    return module


tool = load_tool()


def entry(name: str, **extra: Any) -> dict[str, Any]:
    base: dict[str, Any] = {
        "name": name,
        "title": name.title(),
        "side": "both",
        "required": True,
        "default": True,
        "filename": f"{name}-1.0.jar",
        "src": f"https://cdn.example/{name}-1.0.jar",
        "sha256": "AB" * 32,
    }
    base.update(extra)
    return base


def sha(data: bytes) -> str:
    return hashlib.sha256(data).hexdigest()


class PackTests(unittest.TestCase):
    def setUp(self) -> None:
        self.dir = Path(self.enterContext(tempfile.TemporaryDirectory()))
        self.tree = self.dir / "tree"
        for rel, text in {
            "config/a.cfg": "a=1\n",
            "config/Universal Tweaks - Bugfixes.cfg": "x\n",
            "scripts/ExpertAE+RS.zs": "zs\n",
            "mods/bundled.jar": "jar",
        }.items():
            (self.tree / rel).parent.mkdir(parents=True, exist_ok=True)
            (self.tree / rel).write_text(text)
        self.out = self.dir / "out"
        self.mods = [
            tool.Mod.from_json(entry("alpha")),
            tool.Mod.from_json(
                entry("beta", side="client", required=False, default=False)
            ),
        ]

    def build(self, preserve: frozenset[str] = frozenset()) -> str:
        result: str = tool.build_pack(
            "E36", "1.12.2", self.mods, self.tree, set(preserve), self.out
        )
        return result

    def index(self) -> dict[str, Any]:
        return tomllib.loads((self.out / "index.toml").read_text())

    def test_hash_chain_is_consistent(self) -> None:
        pack_hash = self.build()
        pack_bytes = (self.out / "pack.toml").read_bytes()
        self.assertEqual(pack_hash, sha(pack_bytes))
        pack = tomllib.loads(pack_bytes.decode())
        self.assertEqual(pack["pack-format"], "packwiz:1.1.0")
        self.assertEqual(pack["versions"], {"minecraft": "1.12.2"})
        self.assertEqual(
            pack["index"]["hash"], sha((self.out / "index.toml").read_bytes())
        )
        for file in self.index()["files"]:
            self.assertEqual(
                file["hash"], sha((self.out / file["file"]).read_bytes()), file["file"]
            )

    def test_every_tree_file_and_mod_is_listed(self) -> None:
        self.build()
        files = {f["file"]: f for f in self.index()["files"]}
        self.assertEqual(
            sorted(files),
            [
                "config/Universal Tweaks - Bugfixes.cfg",
                "config/a.cfg",
                "mods/alpha.pw.toml",
                "mods/beta.pw.toml",
                "mods/bundled.jar",
                "scripts/ExpertAE+RS.zs",
            ],
        )
        self.assertTrue(files["mods/alpha.pw.toml"]["metafile"])
        self.assertNotIn("metafile", files["config/a.cfg"])

    def test_metafiles(self) -> None:
        self.build()
        alpha = tomllib.loads((self.out / "mods/alpha.pw.toml").read_text())
        self.assertEqual(alpha["filename"], "alpha-1.0.jar")
        self.assertEqual(alpha["side"], "both")
        self.assertEqual(
            alpha["download"],
            {
                "url": "https://cdn.example/alpha-1.0.jar",
                "hash-format": "sha256",
                "hash": "ab" * 32,
            },
        )
        self.assertNotIn("option", alpha)
        beta = tomllib.loads((self.out / "mods/beta.pw.toml").read_text())
        self.assertEqual(beta["side"], "client")
        self.assertEqual(beta["option"], {"optional": True, "default": False})

    def test_deterministic(self) -> None:
        first = self.build()
        self.assertEqual(self.build(), first)

    def test_preserve(self) -> None:
        self.build(frozenset({"config/a.cfg"}))
        files = {f["file"]: f for f in self.index()["files"]}
        self.assertTrue(files["config/a.cfg"]["preserve"])
        with self.assertRaisesRegex(tool.PackwizError, "preserve lists"):
            self.build(frozenset({"config/missing.cfg"}))

    def test_clashing_install_paths_fail(self) -> None:
        self.mods.append(tool.Mod.from_json(entry("bundled", filename="bundled.jar")))
        with self.assertRaisesRegex(tool.PackwizError, "both install mods/bundled.jar"):
            self.build()

    def test_server_mods_are_rejected(self) -> None:
        with self.assertRaisesRegex(tool.PackwizError, "side 'server'"):
            tool.Mod.from_json(entry("srv", side="server"))

    def test_toml_escaping(self) -> None:
        self.assertEqual(
            tomllib.loads(f"x = {tool.toml_string('a"b\\c\u0001')}")["x"],
            'a"b\\c\u0001',
        )

    def test_unsafe_paths_fail(self) -> None:
        for bad in ("../x", "/etc/x", "C:evil.jar", "a\\b"):
            with self.assertRaises(tool.PackwizError, msg=bad):
                tool.check_path(bad)


class InstanceTests(unittest.TestCase):
    def setUp(self) -> None:
        self.dir = Path(self.enterContext(tempfile.TemporaryDirectory()))
        (self.dir / "installer.jar").write_bytes(b"PK-installer")
        (self.dir / "logo.png").write_bytes(b"png")
        self.template = self.dir / "cleanroom.zip"
        self.write_template("0.6.12-alpha")

    def write_template(self, loader: str) -> None:
        """A cut-down Cleanroom release template: mmc-pack.json, patches/, and parts we drop."""
        pack = {
            "formatVersion": 1,
            "components": [
                {"uid": "org.lwjgl3", "version": "3.4.1"},
                {"uid": "net.minecraft", "version": "1.12.2", "important": True},
                {"uid": "net.minecraftforge", "version": loader},
            ],
        }
        with zipfile.ZipFile(self.template, "w") as archive:
            archive.writestr("mmc-pack.json", json.dumps(pack))
            archive.writestr(
                "patches/net.minecraft.json", '{"compatibleJavaMajors": [25, 26]}'
            )
            archive.writestr("patches/", "")
            archive.writestr(
                "instance.cfg", "JavaPath=Replace this with your java path\n"
            )
            archive.writestr("cleanroom.png", "x")

    def build(self, name: str = "E36", out: str = "E36.zip") -> Path:
        path = self.dir / out
        tool.build_instance(
            name,
            "1.12.2",
            "0.6.12-alpha",
            self.template,
            "https://h.example/pack/prism/e36/pack/pack.toml",
            self.dir / "installer.jar",
            self.dir / "logo.png",
            6144,
            2048,
            path,
        )
        return path

    def test_zip_layout_and_contents(self) -> None:
        with zipfile.ZipFile(self.build()) as archive:
            self.assertEqual(
                sorted(archive.namelist()),
                [
                    "e36.png",
                    "instance.cfg",
                    "minecraft/packwiz-installer.jar",
                    "mmc-pack.json",
                    "patches/net.minecraft.json",
                ],
            )
            cfg = archive.read("instance.cfg").decode()
            pack = json.loads(archive.read("mmc-pack.json"))
            patch = json.loads(archive.read("patches/net.minecraft.json"))
            self.assertEqual(
                archive.read("minecraft/packwiz-installer.jar"), b"PK-installer"
            )
        self.assertIn(
            'PreLaunchCommand="$INST_JAVA" -cp packwiz-installer.jar link.infra.packwiz.installer.Main '
            "--title E36 https://h.example/pack/prism/e36/pack/pack.toml\n",
            cfg,
        )
        self.assertNotIn("bootstrap", cfg)
        self.assertNotIn("JavaPath", cfg)
        self.assertIn("iconKey=e36\n", cfg)
        self.assertEqual(
            pack["components"][2],
            {"uid": "net.minecraftforge", "version": "0.6.12-alpha"},
        )
        self.assertEqual(patch["compatibleJavaMajors"], [25, 26])

    def test_template_for_another_loader_fails(self) -> None:
        self.write_template("0.6.13-alpha")
        with self.assertRaisesRegex(
            tool.PackwizError, "loader is 0.6.13-alpha, not 0.6.12-alpha"
        ):
            self.build()

    def test_zip_is_deterministic(self) -> None:
        self.assertEqual(
            self.build(out="a.zip").read_bytes(), self.build(out="b.zip").read_bytes()
        )

    def test_bad_names_and_commands_fail(self) -> None:
        with self.assertRaisesRegex(tool.PackwizError, "instance name"):
            self.build(name="E 36")
        with self.assertRaisesRegex(tool.PackwizError, "can't contain"):
            tool.instance_cfg("E36", "https://h.example/p?a=b", 6144, 2048)


class SelectModsTests(unittest.TestCase):
    def test_exclude(self) -> None:
        mods = [tool.Mod.from_json(entry("a")), tool.Mod.from_json(entry("relauncher"))]
        self.assertEqual(
            [m.name for m in tool.select_mods(mods, {"relauncher"})], ["a"]
        )
        with self.assertRaisesRegex(tool.PackwizError, "doesn't have: \\['typo'\\]"):
            tool.select_mods(mods, {"typo"})


if __name__ == "__main__":
    unittest.main()
