"""Unit tests for tools/golden/golden_tree.py."""

from __future__ import annotations

import hashlib
import importlib.util
import os
import tempfile
import unittest
from pathlib import Path

ROOT = Path(__file__).resolve().parents[1]
spec = importlib.util.spec_from_file_location(
    "golden_tree", ROOT / "tools/golden/golden_tree.py"
)
assert spec is not None and spec.loader is not None
golden_tree = importlib.util.module_from_spec(spec)
spec.loader.exec_module(golden_tree)


def sha(data: bytes) -> str:
    return hashlib.sha256(data).hexdigest()


class GoldenTreeTests(unittest.TestCase):
    def setUp(self) -> None:
        self.tmp = Path(self.enterContext(tempfile.TemporaryDirectory()))

    def test_files_modes_and_symlinks(self) -> None:
        target = self.tmp / "elsewhere"
        (target / "sub").mkdir(parents=True)
        (target / "sub" / "b.txt").write_bytes(b"bee")
        out = self.tmp / "out"
        out.mkdir()
        (out / "a.txt").write_bytes(b"a")
        script = out / "start.py"
        script.write_bytes(b"#!x")
        script.chmod(0o755)
        os.symlink(target / "sub", out / "linked")  # a symlinked directory
        os.symlink(target / "sub" / "b.txt", out / "b-link")  # a symlinked file
        os.symlink(self.tmp / "missing", out / "dangling")

        lines = golden_tree.golden_tree({"srv": out})

        self.assertEqual(
            lines,
            [
                f"srv/a.txt\tf\t1\t{sha(b'a')}",
                f"srv/b-link\tf\t3\t{sha(b'bee')}",
                f"srv/dangling\tbroken\t->\t{self.tmp / 'missing'}",
                f"srv/linked/b.txt\tf\t3\t{sha(b'bee')}",
                f"srv/start.py\tx\t3\t{sha(b'#!x')}",
            ],
        )

    def test_single_file_root_and_sorting_across_roots(self) -> None:
        xml = self.tmp / "ServerPack.xml"
        xml.write_bytes(b"<xml/>")
        mods = self.tmp / "mods"
        mods.mkdir()
        (mods / "z.jar").write_bytes(b"z")

        lines = golden_tree.golden_tree({"mods": mods, "ServerPack.xml": xml})

        self.assertEqual(
            lines,
            [
                f"ServerPack.xml\tf\t6\t{sha(b'<xml/>')}",
                f"mods/z.jar\tf\t1\t{sha(b'z')}",
            ],
        )

    def test_parse_args(self) -> None:
        self.assertEqual(golden_tree.parse_args(["a=/x"]), {"a": Path("/x")})
        for bad in (["nope"], ["=/x"], ["a="], ["a=/x", "a=/y"], []):
            with self.subTest(bad=bad), self.assertRaises(SystemExit):
                golden_tree.parse_args(bad)


if __name__ == "__main__":
    unittest.main()
