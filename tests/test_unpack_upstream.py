"""lib/unpack_upstream.py: upstream overrides, tombstones, sides, line endings and the overlay."""

from __future__ import annotations

import importlib.util
import tempfile
import unittest
import zipfile
from pathlib import Path
from types import ModuleType

ROOT = Path(__file__).resolve().parents[1]


def load_tool() -> ModuleType:
    """The tool's file name isn't a package path, so load it by location."""
    spec = importlib.util.spec_from_file_location(
        "unpack_upstream", ROOT / "lib/unpack_upstream.py"
    )
    assert spec is not None and spec.loader is not None
    module = importlib.util.module_from_spec(spec)
    spec.loader.exec_module(module)
    return module


tool = load_tool()

UPSTREAM = {
    "overrides/config/a.cfg": b"a=1\r\nb=2\r\n",
    "overrides/config/keep.ini": b"x\r\n",
    "overrides/config/old.cfg": b"gone\r\n",
    "overrides/resources/pack.mcmeta": b"{}\r\n",
    "overrides/mods/thing.jar": b"PK\r\n\x00",
    "manifest.json": b"{}",
}


class UnpackUpstreamTests(unittest.TestCase):
    def setUp(self) -> None:
        self.dir = Path(self.enterContext(tempfile.TemporaryDirectory()))
        self.zip = self.dir / "pack.zip"
        with zipfile.ZipFile(self.zip, "w") as archive:
            for name, data in UPSTREAM.items():
                archive.writestr(name, data)
        self.removed = self.dir / "removed.txt"
        self.removed.write_text("# dropped by us\nconfig/old.cfg\n\n")
        self.overlay = self.dir / "overlay"
        self.out = {"common": self.dir / "common", "client": self.dir / "client"}

    def put(self, rel: str, data: bytes) -> None:
        path = self.overlay / rel
        path.parent.mkdir(parents=True, exist_ok=True)
        path.write_bytes(data)

    def build(self) -> None:
        tool.build(
            self.zip,
            self.removed,
            self.overlay,
            {"resources"},
            {".cfg", ".mcmeta"},
            self.out,
        )

    def tree(self, side: str) -> dict[str, bytes]:
        root = self.out[side]
        return {
            str(p.relative_to(root)): p.read_bytes()
            for p in root.rglob("*")
            if p.is_file()
        }

    def test_sides_tombstones_and_line_endings(self) -> None:
        self.build()
        self.assertEqual(
            self.tree("common"),
            {
                "config/a.cfg": b"a=1\nb=2\n",
                "config/keep.ini": b"x\r\n",
                "mods/thing.jar": b"PK\r\n\x00",
            },
        )
        self.assertEqual(self.tree("client"), {"resources/pack.mcmeta": b"{}\n"})

    def test_overlay_replaces_and_adds(self) -> None:
        self.put("common/config/a.cfg", b"a=2\n")
        self.put("common/config/new.cfg", b"new\n")
        self.put("client/config/client.json", b"{}\n")
        self.build()
        self.assertEqual(self.tree("common")["config/a.cfg"], b"a=2\n")
        self.assertEqual(self.tree("common")["config/new.cfg"], b"new\n")
        self.assertEqual(self.tree("client")["config/client.json"], b"{}\n")

    def test_outputs_are_plain_readable_files(self) -> None:
        self.build()
        self.assertEqual(
            (self.out["common"] / "config/a.cfg").stat().st_mode & 0o777, 0o644
        )

    def test_stale_tombstone_fails(self) -> None:
        self.removed.write_text("config/old.cfg\nconfig/never-there.cfg\n")
        with self.assertRaisesRegex(tool.UpstreamError, "never-there"):
            self.build()

    def test_dead_edit_fails(self) -> None:
        self.put("common/config/a.cfg", b"a=1\nb=2\n")
        with self.assertRaisesRegex(tool.UpstreamError, "identical to upstream"):
            self.build()

    def test_tombstoned_and_overlaid_fails(self) -> None:
        self.put("common/config/old.cfg", b"ours\n")
        with self.assertRaisesRegex(tool.UpstreamError, "both tombstoned"):
            self.build()

    def test_escaping_zip_entry_fails(self) -> None:
        with zipfile.ZipFile(self.zip, "a") as archive:
            archive.writestr("overrides/../evil.cfg", b"x")
        with self.assertRaisesRegex(tool.UpstreamError, "unsafe path"):
            self.build()

    def test_main_reports_errors_as_exit_status(self) -> None:
        self.removed.write_text("config/never-there.cfg\n")
        args = [
            "--zip",
            str(self.zip),
            "--removed",
            str(self.removed),
            "--overlay",
            str(self.overlay),
        ]
        args += [
            "--common",
            str(self.out["common"]),
            "--client",
            str(self.out["client"]),
        ]
        self.assertEqual(tool.main(args), 1)


if __name__ == "__main__":
    unittest.main()
