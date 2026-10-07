import datetime
import os
from pathlib import Path
import sys
import tempfile
import types
import unittest
from unittest.mock import patch


ROOT = Path(__file__).resolve().parents[1]


class _Anything:
    def __init__(self, *args, **kwargs): pass
    def print(self, *args, **kwargs): print(*args)


def _stub_rich():
    """The check runs under plain python3 (a withPackages wrapper breaks test_shutdown's cmdline match)."""
    try:
        import rich  # noqa: F401
        return
    except ImportError:
        pass
    for name in ("rich", "rich.console", "rich.panel", "rich.progress", "rich.table", "rich.prompt",
                 "rich.logging", "rich.live", "rich.text", "rich.markup"):
        module = types.ModuleType(name)
        module.__getattr__ = lambda attr: (lambda s: s) if attr == "escape" else _Anything
        sys.modules[name] = module


def load_start(cwd):
    """start.py is a template: fill its placeholders and load it with cwd as APP_ROOT_DIR."""
    _stub_rich()
    source = (ROOT / "runtime/start.py").read_text()
    source = source.replace("@rconPort@", "0")
    # Like `python3 start.py`, which puts its own directory first on sys.path (crash_analysis, managed_files).
    if str(ROOT / "runtime") not in sys.path:
        sys.path.insert(0, str(ROOT / "runtime"))
    module = types.ModuleType("start")
    module.__file__ = str(ROOT / "runtime/start.py")
    old = os.getcwd()
    os.chdir(cwd)
    try:
        exec(compile(source, module.__file__, "exec"), module.__dict__)
    finally:
        os.chdir(old)
    return module


class DailyRestartTests(unittest.TestCase):
    def setUp(self):
        self.dir = Path(self.enterContext(tempfile.TemporaryDirectory()))
        self.start = load_start(self.dir)
        self.calls = self.dir / "calls"

    def stop_script(self, *exit_codes):
        """Each run appends a line to `calls` and exits with the next code."""
        script = self.dir / "stop.sh"
        codes = " ".join(map(str, exit_codes))
        script.write_text(f"#!/bin/sh\necho x >> '{self.calls}'\n"
                          f"set -- {codes}\nn=$(wc -l < '{self.calls}')\n"
                          f"eval \"exit \\${{$n}}\"\n")
        script.chmod(0o755)

    def run_task(self, *times):
        """Run the real daily_restart_task, waking once per entry in `times`."""
        clock = iter(times)
        wakes = iter([False] * len(times) + [True])
        fake_datetime = types.SimpleNamespace(datetime=types.SimpleNamespace(now=lambda: next(clock)))
        with patch.object(self.start, "datetime", fake_datetime), \
             patch.object(self.start.daily_restart_stop_event, "wait", lambda _: next(wakes)):
            self.start.daily_restart_task()
        return len(self.calls.read_text().splitlines()) if self.calls.exists() else 0

    def test_real_stop_ends_task_and_marks_intentional(self):
        self.stop_script(0)
        runs = self.run_task(datetime.datetime(2026, 9, 26, 17, 59, 30),
                             datetime.datetime(2026, 9, 26, 18, 0, 15),
                             datetime.datetime(2026, 9, 26, 18, 1, 0))
        self.assertEqual(runs, 1)
        self.assertTrue(self.start.stop_requested)

    def test_lazy_skip_keeps_waiting_for_next_restart(self):
        self.stop_script(self.start.LAZY_SKIP_EXIT, 0)
        runs = self.run_task(datetime.datetime(2026, 9, 26, 18, 0, 8),
                             datetime.datetime(2026, 9, 26, 18, 0, 53),  # same minute: no second run
                             datetime.datetime(2026, 9, 26, 18, 1, 38),
                             datetime.datetime(2026, 9, 27, 6, 0, 20),
                             datetime.datetime(2026, 9, 27, 6, 1, 5))
        self.assertEqual(runs, 2)
        self.assertTrue(self.start.stop_requested)

    def test_lazy_skip_leaves_crash_detection_armed(self):
        self.stop_script(self.start.LAZY_SKIP_EXIT)
        runs = self.run_task(datetime.datetime(2026, 9, 26, 18, 0, 8),
                             datetime.datetime(2026, 9, 26, 18, 0, 53))
        self.assertEqual(runs, 1)
        self.assertFalse(self.start.stop_requested)


if __name__ == "__main__":
    unittest.main()
