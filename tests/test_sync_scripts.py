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

    def test_missing_envrc_is_skipped(self):
        (self.base / "control.sh").write_text("control\n")

        self.sync()

        self.assertTrue((self.world / "control.sh").exists())
        self.assertFalse((self.world / ".envrc").exists())


if __name__ == "__main__":
    unittest.main()
