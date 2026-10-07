"""start.py's sync step copies the helper scripts and the direnv .envrc into the world."""

import tempfile
import unittest
from pathlib import Path
from unittest.mock import MagicMock, patch

from test_daily_restart import load_start


class SyncScriptsTests(unittest.TestCase):
    def setUp(self):
        self.dir = Path(self.enterContext(tempfile.TemporaryDirectory()))
        self.start = load_start(self.dir)
        self.base = self.dir / "store"
        self.world = self.dir / "world"
        self.base.mkdir()
        self.world.mkdir()

    def sync(self):
        """Run the real sync_server_files with no rsync and a silent console."""
        with patch.object(self.start, "BASE_DIR", self.base), \
             patch.object(self.start, "APP_ROOT_DIR", self.world), \
             patch.object(self.start, "LOGS_DIR", self.world / "logs"), \
             patch.object(self.start, "run_command", MagicMock()), \
             patch.object(self.start, "console", MagicMock()):
            self.start.sync_server_files()

    def test_scripts_and_envrc_replace_stale_copies(self):
        (self.base / "control.sh").write_text("new control\n")
        (self.base / ".envrc").write_text("new envrc\n")
        (self.world / ".envrc").write_text("old envrc\n")

        self.sync()

        self.assertEqual((self.world / "control.sh").read_text(), "new control\n")
        self.assertEqual((self.world / ".envrc").read_text(), "new envrc\n")

    def test_user_jvm_args_is_managed_and_other_seeds_are_not(self):
        (self.base / "user_jvm_args.txt").write_text("-Xmx8G\n")
        (self.base / "server.properties").write_text("motd=pack\n")
        (self.base / "ops.json").write_text("[]\n")
        (self.world / "user_jvm_args.txt").write_text("-Xmx1G\n")
        (self.world / "server.properties").write_text("motd=admin\n")

        self.sync()

        self.assertEqual((self.world / "user_jvm_args.txt").read_text(), "-Xmx8G\n")
        self.assertEqual((self.world / "server.properties").read_text(), "motd=admin\n")
        self.assertEqual((self.world / "ops.json").read_text(), "[]\n")

    def test_sync_retires_a_dropped_config(self):
        (self.base / "config").mkdir()
        (self.base / "config/kept.cfg").write_text("k")
        (self.base / "config/dropped.cfg").write_text("d")
        for name in ("kept.cfg", "dropped.cfg"):  # what rsync would have copied
            (self.world / "config").mkdir(exist_ok=True)
            (self.world / "config" / name).write_text(name)
        self.sync()
        (self.base / "config/dropped.cfg").unlink()
        # rsync -a copies the store's read-only directory modes; fix_permissions undoes that later.
        (self.world / "config").chmod(0o555)

        self.sync()

        self.assertTrue((self.world / "config/kept.cfg").exists())
        self.assertFalse((self.world / "config/dropped.cfg").exists())
        self.assertEqual(len(list((self.world / ".erisia-removed").rglob("dropped.cfg"))), 1)

    def test_untrusted_manifest_stops_the_start(self):
        (self.base / "control.sh").write_text("control\n")
        (self.world / ".erisia-managed.json").write_text("{bad")
        with self.assertRaises(SystemExit) as stop:
            self.sync()
        self.assertEqual(stop.exception.code, 1)
        self.assertEqual((self.world / ".erisia-managed.json").read_text(), "{bad")

    def test_missing_envrc_is_skipped(self):
        (self.base / "control.sh").write_text("control\n")

        self.sync()

        self.assertTrue((self.world / "control.sh").exists())
        self.assertFalse((self.world / ".envrc").exists())


if __name__ == "__main__":
    unittest.main()
