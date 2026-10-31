"""start.py's hang watchdog: kill a JVM that crashed but didn't exit (Incognito, 2026-10-30)."""

import tempfile
import unittest
from pathlib import Path

from test_daily_restart import load_start


class FakeProcess:
    def __init__(self, polls_alive):
        self.pid = 4242
        self.polls_alive = polls_alive
        self.killed = False

    def poll(self):
        if self.killed:
            return -9
        if self.polls_alive is not None:
            if self.polls_alive <= 0:
                return 0
            self.polls_alive -= 1
        return None


class HangWatchdogTests(unittest.TestCase):
    def setUp(self):
        self.dir = Path(self.enterContext(tempfile.TemporaryDirectory()))
        self.start = load_start(self.dir)
        self.start.LOGS_DIR = self.dir / "logs"
        self.start.LOGS_DIR.mkdir()
        self.log = self.start.LOGS_DIR / "latest.log"
        self.start.time.sleep = lambda _s: None
        self.clock = [0.0]

        def monotonic():
            self.clock[0] += 10
            return self.clock[0]

        self.start.time.monotonic = monotonic
        self.kills = []

    def run_watchdog(self, process):
        def kill(pid, timeout_sec=180):
            self.kills.append(pid)
            process.killed = True

        self.start.kill_java_process_fallback = kill
        self.start.hang_watchdog_task(process)

    def tearDown(self):
        import time
        self.start.time.sleep = time.sleep
        self.start.time.monotonic = time.monotonic

    def test_kills_a_jvm_still_up_after_the_watchdog_verdict(self):
        self.log.write_text(
            "[Server Watchdog/ERROR]: A single server tick took 60.00 seconds\n"
            "[Server Watchdog/ERROR]: Considering it to be crashed, server will forcibly shutdown.\n")
        self.run_watchdog(FakeProcess(polls_alive=None))
        self.assertEqual(self.kills, [4242])

    def test_leaves_a_healthy_server_alone(self):
        self.log.write_text("[Server thread/INFO]: Done (6.2s)! For help, type \"help\"\n")
        self.run_watchdog(FakeProcess(polls_alive=40))
        self.assertEqual(self.kills, [])

    def test_a_crash_that_exits_in_time_is_not_killed(self):
        self.log.write_text("This crash report has been saved to: crash-reports/x.txt\n")
        self.run_watchdog(FakeProcess(polls_alive=3))
        self.assertEqual(self.kills, [])


if __name__ == "__main__":
    unittest.main()
