import importlib.util
from contextlib import ExitStack
import os
from pathlib import Path
import select
import subprocess
import sys
import tempfile
import threading
import time
import unittest
from unittest.mock import patch


ROOT = Path(__file__).resolve().parents[1]
spec = importlib.util.spec_from_file_location("shutdown", ROOT / "shutdown.py")
shutdown = importlib.util.module_from_spec(spec)
spec.loader.exec_module(shutdown)


class ShutdownTests(unittest.TestCase):
    def setUp(self):
        self.stack = ExitStack()
        self.addCleanup(self.stack.close)
        self.home = Path(self.stack.enter_context(tempfile.TemporaryDirectory()))

    def server(self, name):
        world = self.home / name
        (world / "server").mkdir(parents=True)
        launcher = world / "server/start.py"
        launcher.write_text("import time\ntime.sleep(60)\n")
        process = subprocess.Popen([sys.executable, str(launcher)])

        def cleanup():
            if process.poll() is None:
                process.kill()
            process.wait()

        self.stack.callback(cleanup)
        (world / "server.pid").write_text(str(process.pid))
        return world, process

    def test_discovery_rejects_stale_and_reused_pids(self):
        world, _ = self.server("live")
        stale = self.home / "stale"
        stale.mkdir()
        (stale / "server.pid").write_text("not-a-pid")
        reused = self.home / "reused"
        reused.mkdir()
        (reused / "server.pid").write_text(str(os.getpid()))
        self.assertEqual([w for w, _ in shutdown.running_servers(self.home, self.stack)], [world])

    def test_controls_run_in_parallel_and_marker_precedes_them(self):
        marker = self.home / "shutdown"
        for name in ("one", "two"):
            world, _ = self.server(name)
            control = world / "control.sh"
            control.write_text(f'''#!{sys.executable}
import os, pathlib, signal, sys, time
world = pathlib.Path.cwd()
assert sys.argv[1:] == ["stop", "-t", "10"]
assert (world.parent / "shutdown").exists()
(world / "called").touch()
deadline = time.monotonic() + 3
while len(list(world.parent.glob("*/called"))) != 2:
    assert time.monotonic() < deadline, "controls were serialized"
    time.sleep(0.01)
os.kill(int((world / "server.pid").read_text()), signal.SIGTERM)
''')
            control.chmod(0o755)
        shutdown.shutdown(self.home, marker, 10)
        self.assertTrue(marker.exists())
        self.assertEqual(len(list(self.home.glob("*/called"))), 2)

    def test_control_failure_still_waits_for_server(self):
        world, process = self.server("failed-control")
        control = world / "control.sh"
        control.write_text(f"#!{sys.executable}\nimport sys\nsys.exit(1)\n")
        control.chmod(0o755)
        servers = shutdown.running_servers(self.home, self.stack)
        timer = threading.Timer(0.3, process.terminate)
        timer.start()
        self.stack.callback(timer.join)
        before = time.monotonic()
        shutdown.shutdown(self.home, self.home / "shutdown", 0)
        self.assertGreaterEqual(time.monotonic() - before, 0.25)
        self.assertTrue(select.select([servers[0][1]], [], [], 0)[0])

    def test_no_servers_returns_immediately_but_blocks_restarts(self):
        marker = self.home / "shutdown"
        with patch.object(shutdown, "running_servers") as discover:
            def check_marker(home, stack):
                self.assertTrue(marker.exists(), "restart guard must precede discovery")
                return []
            discover.side_effect = check_marker
            shutdown.shutdown(self.home, marker, 10)
        self.assertTrue(marker.exists())

    def test_update_wrapper_refuses_restart_before_building(self):
        # Select a temporary marker path without touching /run/user.
        wrapper = self.home / "update-and-start.sh"
        wrapper.write_text((ROOT / "update-and-start.sh").read_text().replace(
            '/run/user/$(id -u)/minecraft-shutdown', str(self.home / 'shutdown')))
        (self.home / "shutdown").touch()
        result = subprocess.run(["bash", str(wrapper)], cwd=self.home, capture_output=True, text=True)
        self.assertEqual(result.returncode, 1)
        self.assertIn("refusing to start", result.stdout)
        self.assertNotIn("doesn't look like", result.stdout)


if __name__ == "__main__":
    unittest.main()
