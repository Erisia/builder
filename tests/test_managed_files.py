"""runtime/managed_files.py: the managed-file manifest and retiring files the pack dropped."""

from __future__ import annotations

import importlib.util
import json
import tempfile
import unittest
from pathlib import Path
from types import ModuleType

ROOT = Path(__file__).resolve().parents[1]


def load_module() -> ModuleType:
    """runtime/ isn't a package, so load the module by location."""
    spec = importlib.util.spec_from_file_location(
        "managed_files", ROOT / "runtime/managed_files.py"
    )
    assert spec is not None and spec.loader is not None
    module = importlib.util.module_from_spec(spec)
    spec.loader.exec_module(module)
    return module


managed = load_module()
DIRS = ["config", "scripts"]


class ManagedFilesTests(unittest.TestCase):
    def setUp(self) -> None:
        self.dir = Path(self.enterContext(tempfile.TemporaryDirectory()))
        self.base = self.dir / "server"
        self.world = self.dir / "world"
        self.world.mkdir()
        self.logs: list[str] = []

    def ship(self, *paths: str) -> None:
        """Make the pack ship exactly `paths`, and sync them into the world like rsync would."""
        if self.base.exists():
            for path in sorted(self.base.rglob("*"), reverse=True):
                path.rmdir() if path.is_dir() else path.unlink()
        for rel in paths:
            for root in (self.base, self.world):
                (root / rel).parent.mkdir(parents=True, exist_ok=True)
                (root / rel).write_text(rel)

    def world_file(self, rel: str, text: str = "generated") -> None:
        (self.world / rel).parent.mkdir(parents=True, exist_ok=True)
        (self.world / rel).write_text(text)

    def update(self, stamp: str = "s1") -> list[str]:
        result: list[str] = managed.update(
            self.base, self.world, DIRS, stamp, self.logs.append
        )
        return result

    def test_first_start_retires_nothing_and_records(self) -> None:
        self.ship("config/a.cfg", "scripts/b.zs")
        self.world_file("config/stale-from-before.cfg")
        self.assertEqual(self.update(), [])
        self.assertTrue((self.world / "config/stale-from-before.cfg").exists())
        manifest = json.loads((self.world / managed.MANIFEST_NAME).read_text())
        self.assertEqual(
            manifest, {"version": 1, "files": ["config/a.cfg", "scripts/b.zs"]}
        )

    def test_dropped_file_is_moved_not_deleted(self) -> None:
        self.ship("config/a.cfg", "config/sub/b.cfg")
        self.update()
        self.ship("config/a.cfg")
        self.assertEqual(self.update("s2"), ["config/sub/b.cfg"])
        self.assertFalse((self.world / "config/sub/b.cfg").exists())
        self.assertEqual(
            (self.world / managed.REMOVED_DIR_NAME / "s2/config/sub/b.cfg").read_text(),
            "config/sub/b.cfg",
        )
        self.assertTrue((self.world / "config/a.cfg").exists())
        self.assertIn("config/sub/b.cfg", self.logs[0])

    def test_generated_files_are_never_touched(self) -> None:
        self.ship("config/a.cfg")
        self.update()
        self.world_file("config/generated.dat")
        self.ship()
        self.assertEqual(self.update("s2"), ["config/a.cfg"])
        self.assertTrue((self.world / "config/generated.dat").exists())

    def test_dirs_outside_the_list_are_ignored(self) -> None:
        self.ship("config/a.cfg", "other/x.txt")
        self.update()
        self.assertEqual(managed.read_manifest(self.world), {"config/a.cfg"})

    def test_already_gone_and_directories_are_skipped(self) -> None:
        self.ship("config/a.cfg")
        self.update()
        (self.world / "config/a.cfg").unlink()
        (self.world / "config/a.cfg").mkdir()
        self.ship()
        self.assertEqual(self.update("s2"), [])
        self.assertTrue((self.world / "config/a.cfg").is_dir())

    def test_unsafe_manifest_entries_refuse(self) -> None:
        outside = self.dir / "outside.txt"
        outside.write_text("keep")
        (self.world / managed.MANIFEST_NAME).write_text(
            json.dumps({"version": 1, "files": ["../outside.txt"]})
        )
        self.ship()
        with self.assertRaisesRegex(managed.ManagedFilesError, "outside the world"):
            self.update()
        self.assertTrue(outside.exists())

    def test_corrupt_manifest_refuses_and_is_kept_for_inspection(self) -> None:
        self.ship("config/a.cfg")
        self.world_file("config/old.cfg")
        (self.world / managed.MANIFEST_NAME).write_text("{not json")
        with self.assertRaisesRegex(managed.ManagedFilesError, "unreadable"):
            self.update()
        self.assertTrue((self.world / "config/old.cfg").exists())
        self.assertEqual((self.world / managed.MANIFEST_NAME).read_text(), "{not json")

    def test_wrong_version_or_shape_refuses(self) -> None:
        for data in (
            {"version": 2, "files": []},
            {"version": 1, "files": [1]},
            ["config/a.cfg"],
        ):
            (self.world / managed.MANIFEST_NAME).write_text(json.dumps(data))
            with self.assertRaises(managed.ManagedFilesError):
                managed.read_manifest(self.world)

    def test_failed_move_refuses_and_keeps_the_old_manifest(self) -> None:
        self.ship("config/a.cfg", "config/b.cfg")
        self.update()
        before = (self.world / managed.MANIFEST_NAME).read_text()
        self.ship("config/a.cfg")
        (self.world / "config").chmod(0o555)
        try:
            with self.assertRaisesRegex(
                managed.ManagedFilesError, "couldn't move config/b.cfg"
            ):
                self.update("s2")
        finally:
            (self.world / "config").chmod(0o755)
        self.assertEqual((self.world / managed.MANIFEST_NAME).read_text(), before)
        self.assertEqual(self.update("s3"), ["config/b.cfg"])

    def test_symlinked_store_files_count(self) -> None:
        target = self.dir / "elsewhere/real.cfg"
        target.parent.mkdir(parents=True)
        target.write_text("x")
        (self.base / "config").mkdir(parents=True)
        (self.base / "config/link.cfg").symlink_to(target)
        (self.base / "scripts").symlink_to(target.parent, target_is_directory=True)
        self.assertEqual(
            managed.shipped_files(self.base, DIRS),
            {"config/link.cfg", "scripts/real.cfg"},
        )


if __name__ == "__main__":
    unittest.main()
