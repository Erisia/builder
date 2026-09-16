import datetime
import importlib.util
import json
import os
from pathlib import Path
import stat
import subprocess
import sys
import tempfile
import unittest
import urllib.error
from contextlib import contextmanager
from unittest.mock import patch


ROOT = Path(__file__).resolve().parents[1]
spec = importlib.util.spec_from_file_location("crash_analysis", ROOT / "base/server/crash_analysis.py")
crash_analysis = importlib.util.module_from_spec(spec)
spec.loader.exec_module(crash_analysis)

NOW = datetime.datetime(2026, 9, 14, 3, 15, 2)
LAUNCHED = NOW - datetime.timedelta(minutes=42)


class CrashDetectionTests(unittest.TestCase):
    def test_only_unrequested_nonzero_exits_are_crashes(self):
        self.assertTrue(crash_analysis.is_crash(1, False, False))
        self.assertTrue(crash_analysis.is_crash(-9, False, False))
        self.assertFalse(crash_analysis.is_crash(0, False, False))
        self.assertFalse(crash_analysis.is_crash(143, True, False), "ctrl-c'd stop is not a crash")
        self.assertFalse(crash_analysis.is_crash(137, False, True), "host shutdown is not a crash")
        self.assertFalse(crash_analysis.is_crash(0, True, False))

    def test_exit_descriptions(self):
        self.assertEqual(crash_analysis.describe_exit(1), "exit status 1")
        self.assertEqual(crash_analysis.describe_exit(-9), "killed by signal SIGKILL")
        self.assertIn("SIGTERM", crash_analysis.describe_exit(143))


class AnalysisStartTests(unittest.TestCase):
    def setUp(self):
        self.server = Path(tempfile.mkdtemp())
        self.addCleanup(lambda: subprocess.run(["rm", "-rf", str(self.server)]))
        (self.server / "logs").mkdir()
        (self.server / "logs/latest.log").write_text("[Server thread/ERROR]: boom\n")
        (self.server / "logs/debug.log").write_text("".join(f"line {i}\n" for i in range(5000)))
        (self.server / "server.nix-target").write_text("e36\n")
        self.launches = []
        self.messages = []

    def launcher(self, python, server_dir, snap, unit_name, log):
        self.launches.append((snap, unit_name))
        return "fake launcher"

    def start(self, return_code=1, stop_requested=False, marker=False, now=NOW):
        return crash_analysis.maybe_start_analysis(
            server_dir=self.server, return_code=return_code, stop_requested=stop_requested,
            shutdown_marker_exists=marker, launched_at=LAUNCHED, command=["java", "-jar", "x.jar"],
            server_name="e36", python=sys.executable, log=self.messages.append, now=now,
            launcher=self.launcher)

    def report_dir(self):
        return self.server / "crash-analysis"

    def test_intentional_stops_leave_no_trace(self):
        self.assertIsNone(self.start(return_code=0))
        self.assertIsNone(self.start(return_code=130, stop_requested=True))
        self.assertIsNone(self.start(return_code=137, marker=True))
        self.assertEqual(self.launches, [])
        self.assertFalse(self.report_dir().exists())

    def test_disabled_by_environment(self):
        with patch.dict(os.environ, {"CRASH_ANALYSIS": "0"}):
            self.assertIsNone(self.start())
        self.assertEqual(self.launches, [])

    def test_crash_snapshots_logs_and_launches_analysis(self):
        old_report = self.server / "crash-reports/crash-old.txt"
        old_report.parent.mkdir()
        old_report.write_text("old")
        old = (LAUNCHED - datetime.timedelta(days=1)).timestamp()
        os.utime(old_report, (old, old))
        new_report = self.server / "crash-reports/crash-new.txt"
        new_report.write_text("new")
        (self.server / "hs_err_pid123.log").write_text("jvm fatal")

        snap = self.start(return_code=-6)

        self.assertEqual(snap, self.report_dir() / "2026-09-14-031502")
        self.assertEqual(self.launches, [(snap, "crash-analysis-e36-2026-09-14-031502")])
        self.assertEqual((snap / "latest.log").read_text(), "[Server thread/ERROR]: boom\n")
        debug_tail = (snap / "debug.log.tail").read_text().splitlines()
        self.assertEqual(len(debug_tail), crash_analysis.DEBUG_TAIL_LINES)
        self.assertEqual(debug_tail[-1], "line 4999")
        self.assertTrue((snap / "crash-reports/crash-new.txt").exists())
        self.assertFalse((snap / "crash-reports/crash-old.txt").exists(), "older crash reports are not evidence")
        self.assertTrue((snap / "hs_err/hs_err_pid123.log").exists())
        context = json.loads((snap / "context.json").read_text())
        self.assertEqual(context["return_code"], -6)
        self.assertEqual(context["exit_description"], "killed by signal SIGABRT")
        self.assertEqual(context["uptime_seconds"], 42 * 60)
        self.assertEqual(context["report_number"], 1)
        self.assertEqual(context["command"], "java -jar x.jar")
        self.assertIn("crashed", self.messages[-1])

    def test_at_most_three_analyses_per_day(self):
        stamps = []
        for minute in range(4):
            snap = self.start(now=NOW + datetime.timedelta(minutes=minute))
            stamps.append(snap)
        self.assertEqual([s is not None for s in stamps], [True, True, True, False])
        self.assertEqual(len(self.launches), 3)
        self.assertIn("limit 3", self.messages[-1])
        # Finished reports and in-progress snapshots both count; the next day starts fresh.
        (self.report_dir() / "2026-09-14-031502.md").write_text("done")
        self.assertEqual(crash_analysis.reports_today(self.report_dir(), NOW), 3)
        self.assertIsNotNone(self.start(now=NOW + datetime.timedelta(days=1)))
        self.assertEqual(len(self.launches), 4)


class LaunchTests(unittest.TestCase):
    def test_systemd_unit_gets_path_and_overrides(self):
        environ = {"PATH": "/bin", "CRASH_ANALYSIS_CLAUDE": "/x/claude", "HOME": "/h", "CRASH_ANALYSIS": "1"}
        self.assertEqual(crash_analysis.systemd_environment(environ),
                         ["--setenv=PATH=/bin", "--setenv=CRASH_ANALYSIS=1", "--setenv=CRASH_ANALYSIS_CLAUDE=/x/claude"])
        self.assertEqual(crash_analysis.systemd_environment({}), [])


class RunAnalysisTests(unittest.TestCase):
    def setUp(self):
        self.server = Path(tempfile.mkdtemp())
        self.addCleanup(lambda: subprocess.run(["rm", "-rf", str(self.server)]))
        environ = patch.dict(os.environ, {"CRASH_ANALYSIS_DISCORD_CONFIG": str(self.server / "no-discord.json")})
        environ.start()
        self.addCleanup(environ.stop)
        (self.server / "logs").mkdir()
        (self.server / "logs/latest.log").write_text("boom\n")
        (self.server / "server.nix-target").write_text("e36\n")
        report_dir = self.server / "crash-analysis"
        report_dir.mkdir()
        (report_dir / "2026-09-13-120000.md").write_text("# earlier\n")
        context = {
            "server_name": "e36", "server_dir": str(self.server),
            "launched_at": LAUNCHED.isoformat(timespec="seconds"),
            "exited_at": NOW.isoformat(timespec="seconds"), "uptime_seconds": 2520.0,
            "return_code": 1, "exit_description": "exit status 1",
            "command": "java -jar x.jar", "report_number": 2,
        }
        self.snap = crash_analysis.snapshot(self.server, report_dir, "2026-09-14-031502", context)

    def fake_claude(self, script):
        path = self.server / "fake-claude"
        path.write_text("#!/bin/sh\n" + script)
        path.chmod(path.stat().st_mode | stat.S_IXUSR)
        return patch.dict(os.environ, {"CRASH_ANALYSIS_CLAUDE": str(path), "CLAUDECODE": "1"})

    def test_prompt_is_advisory_and_mentions_context(self):
        prompt = crash_analysis.build_prompt(json.loads((self.snap / "context.json").read_text()),
                                             self.snap, self.snap.parent)
        for expected in ("Do NOT modify", "not obvious", "nix-shell -p unzip cfr", "mktemp -d",
                         "crash-analysis/2026-09-13-120000.md", "Pack: e36", "analysis 2 of at most 3",
                         "exit status 1", "## Summary", "## Suggestions"):
            self.assertIn(expected, prompt)
        self.assertNotIn("2026-09-14-031502.md", prompt, "the report being written is not a previous report")

    def test_report_wraps_claude_output(self):
        with self.fake_claude('[ -z "$CLAUDECODE" ] || exit 99\n'
                              'printf "%s\\n" "$@" > "$PWD/crash-analysis/2026-09-14-031502/args"\n'
                              'grep -q "## Summary" || exit 98\n'
                              'echo "## Summary"; echo "Something broke."\n'):
            status = crash_analysis.run_analysis(self.server, self.snap)
        self.assertEqual(status, 0)
        report = (self.snap.parent / "2026-09-14-031502.md").read_text()
        self.assertIn("# Crash analysis: e36 2026-09-14-031502", report)
        self.assertIn("Suggestions only: nothing was changed.", report)
        self.assertTrue(report.rstrip().endswith("## Summary\nSomething broke."))
        args = (self.snap / "args").read_text().split("\n")
        self.assertIn("-p", args)
        self.assertIn("--disallowedTools", args)
        self.assertIn("Edit", args[args.index("--disallowedTools"):])
        self.assertTrue((self.snap / "prompt.md").exists())
        self.assertFalse((self.snap / "report.md.tmp").exists())

    def test_failed_claude_still_yields_a_report(self):
        with self.fake_claude('echo "no auth" >&2; exit 3\n'):
            status = crash_analysis.run_analysis(self.server, self.snap)
        self.assertEqual(status, 3)
        report = (self.snap.parent / "2026-09-14-031502.md").read_text()
        self.assertIn("exited with status 3", report)
        self.assertEqual((self.snap / "claude.stderr.log").read_text(), "no auth\n")

    def test_missing_claude_still_yields_a_report(self):
        with patch.dict(os.environ, {"CRASH_ANALYSIS_CLAUDE": str(self.server / "nope"), "PATH": str(self.server)}), \
                patch.object(Path, "home", return_value=self.server):
            status = crash_analysis.run_analysis(self.server, self.snap)
        self.assertEqual(status, 1)
        self.assertIn("no Claude Code binary found", (self.snap.parent / "2026-09-14-031502.md").read_text())
        self.assertFalse((self.server / "web").exists(), "nothing is published without a Discord config")

    def test_run_publishes_when_configured(self):
        web = self.server / "web"
        config = self.server / "discord.json"
        config.write_text(json.dumps({"webhook_url": "https://discord.example/hook", "web_dir": str(web),
                                      "public_url": "https://madoka.example/crash-analysis/"}))
        calls = []

        @contextmanager
        def opener(request, timeout):
            calls.append(request)
            yield FakeResponse(204)

        with self.fake_claude('echo "## Summary"; echo "Out of memory."\n'), \
                patch.dict(os.environ, {"CRASH_ANALYSIS_DISCORD_CONFIG": str(config)}), \
                patch.object(crash_analysis.urllib.request, "urlopen", opener):
            status = crash_analysis.run_analysis(self.server, self.snap)
        self.assertEqual(status, 0)
        copy = web / self.server.name / "2026-09-14-031502.md"
        self.assertEqual(copy.read_text(), (self.snap.parent / "2026-09-14-031502.md").read_text())
        self.assertEqual(len(calls), 1)
        payload = json.loads(calls[0].data)
        self.assertIn(f"https://madoka.example/crash-analysis/{self.server.name}/2026-09-14-031502.md",
                      payload["content"])
        self.assertIn("> Out of memory.", payload["content"])
        self.assertIn("published", (self.snap / "publish.log").read_text())


class FakeResponse:
    def __init__(self, status, body=b'{"id": "1234567890"}'):
        self.status = status
        self.body = body

    def read(self):
        return self.body


class PublishTests(unittest.TestCase):
    def setUp(self):
        self.root = Path(tempfile.mkdtemp())
        self.addCleanup(lambda: subprocess.run(["rm", "-rf", str(self.root)]))
        self.report = self.root / "2026-09-14-031502.md"
        self.report.write_text("# Crash analysis: e36 2026-09-14-031502\n\n- Exit: exit status 1\n\n---\n\n"
                               "## Summary\nThe JVM ran out of heap\nwhile generating chunks.\n\n"
                               "## Evidence\nOutOfMemoryError\n")
        self.context = {"server_name": "e36", "server_dir": "/home/mc/erisia", "exited_at": "2026-09-14T03:15:02",
                        "uptime_seconds": 2520.0, "exit_description": "exit status 1", "report_number": 2}
        self.web = self.root / "web"
        self.config = {"webhook_url": "https://discord.example/hook", "web_dir": self.web,
                       "public_url": "https://madoka.example/crash-analysis",
                       "username": "Crash analysis", "avatar_url": "https://example/icon.jpg"}
        self.messages = []
        self.requests = []

    def opener(self, status=204, error=None):
        @contextmanager
        def open_(request, timeout):
            self.requests.append(request)
            if error:
                raise error
            yield FakeResponse(status)
        return open_

    def test_config_defaults_and_validation(self):
        self.assertIsNone(crash_analysis.load_discord_config(self.root / "missing.json"))
        path = self.root / "discord.json"
        path.write_text(json.dumps({"webhook_url": "https://discord.example/hook"}))
        config = crash_analysis.load_discord_config(path)
        self.assertEqual(config["webhook_url"], "https://discord.example/hook")
        self.assertEqual(config["web_dir"], Path.home() / "web/crash-analysis")
        with patch.object(Path, "home", return_value=self.root):
            self.assertEqual(crash_analysis.load_discord_config(path)["web_dir"], self.root / "web/crash-analysis")
            self.assertIsNone(crash_analysis.load_discord_config(), "default config path follows $HOME")
        self.assertEqual(config["public_url"], "https://madoka.brage.info/crash-analysis")
        self.assertEqual(config["username"], "Crash analysis")
        self.assertTrue(config["avatar_url"].startswith("https://brage.info/"))
        path.write_text(json.dumps({"public_url": "x"}))
        with self.assertRaises(ValueError):
            crash_analysis.load_discord_config(path)

    def test_summary_extraction(self):
        self.assertEqual(crash_analysis.report_summary(self.report.read_text()),
                         "The JVM ran out of heap while generating chunks.")
        failed = "# Crash analysis\n\n- Exit: x\n\n---\n\n**Analysis timed out** after 25 minutes.\n"
        self.assertEqual(crash_analysis.report_summary(failed), "**Analysis timed out** after 25 minutes.")

    def test_message_fits_discord_limit(self):
        payload = crash_analysis.discord_message(self.context, self.report.read_text(), "https://x/r.md",
                                                 "Crash analysis", "https://example/icon.jpg")
        self.assertEqual(payload["content"], "**erisia (e36) crashed** at 2026-09-14T03:15:02 (exit status 1, uptime 0:42:00). "
                         "Analysis 2 of at most 3 today.\n> The JVM ran out of heap while generating chunks.\nhttps://x/r.md")
        self.assertEqual(payload["allowed_mentions"], {"parse": []})
        self.assertEqual(payload["username"], "Crash analysis")
        self.assertEqual(payload["avatar_url"], "https://example/icon.jpg")
        huge = "## Summary\n" + "word " * 1000
        payload = crash_analysis.discord_message(self.context, huge, "https://x/r.md")
        self.assertLessEqual(len(payload["content"]), crash_analysis.DISCORD_CONTENT_LIMIT)
        self.assertTrue(payload["content"].endswith("\nhttps://x/r.md"))

    def test_publish_copies_and_posts(self):
        url = crash_analysis.publish_report(self.report, self.context, self.messages.append,
                                            config=self.config, opener=self.opener())
        self.assertEqual(url, "https://madoka.example/crash-analysis/erisia/2026-09-14-031502.md")
        copy = self.web / "erisia/2026-09-14-031502.md"
        self.assertEqual(copy.read_text(), self.report.read_text())
        self.assertEqual(stat.S_IMODE(copy.stat().st_mode), 0o644)
        self.assertEqual(os.listdir(self.web / "erisia"), ["2026-09-14-031502.md"], "no temp file left behind")
        request = self.requests[0]
        self.assertEqual(request.full_url, "https://discord.example/hook?wait=true")
        self.assertEqual(request.get_header("Content-type"), "application/json")
        self.assertIn(url, json.loads(request.data)["content"])
        self.assertIn("message 1234567890", self.messages[-1])

    def test_webhook_failures_are_logged_not_raised(self):
        error = urllib.error.HTTPError("https://discord.example/hook", 429, "Too Many Requests", {},
                                       __import__("io").BytesIO(b'{"retry_after": 5}'))
        url = crash_analysis.publish_report(self.report, self.context, self.messages.append,
                                            config=self.config, opener=self.opener(error=error))
        self.assertIsNone(url)
        self.assertTrue((self.web / "erisia/2026-09-14-031502.md").exists(), "the web copy is kept regardless")
        self.assertIn("HTTP 429", self.messages[-1])
        self.assertIn("retry_after", self.messages[-1])

        url = crash_analysis.publish_report(self.report, self.context, self.messages.append, config=self.config,
                                            opener=self.opener(error=urllib.error.URLError("no route")))
        self.assertIsNone(url)
        self.assertIn("no route", self.messages[-1])

    def test_unwritable_web_dir_is_logged(self):
        self.config["web_dir"] = self.root / "file-not-dir"
        self.config["web_dir"].write_text("")
        url = crash_analysis.publish_report(self.report, self.context, self.messages.append,
                                            config=self.config, opener=self.opener())
        self.assertIsNone(url)
        self.assertEqual(self.requests, [], "no announcement without a copy to link to")
        self.assertIn("could not copy", self.messages[-1])


if __name__ == "__main__":
    unittest.main()
