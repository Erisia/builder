#!/usr/bin/env python3
"""Suggestion-only crash post-mortems via Claude Code.

start.py calls maybe_start_analysis() once the Java process has exited. When
the exit was a crash (nonzero status, no stop requested by the launcher, no
host shutdown in progress) the logs are snapshotted into
``crash-analysis/<stamp>/`` and this file is re-run detached
(``crash_analysis.py run SERVER_DIR SNAPSHOT_DIR``) to ask Claude Code for a
diagnosis. The finished report lands beside the snapshot as
``crash-analysis/<stamp>.md``; tools/crash-analysis-notice.sh calls out unread
reports at the shell prompt.

The analysis is advisory only: the prompt forbids changing the server, and the
launcher never waits for it (the restart loop carries on). At most DAILY_LIMIT
analyses are started per calendar day, counting attempts rather than
successes. Set CRASH_ANALYSIS=0 in the launcher's environment to disable it.
"""

import datetime
import json
import os
import shutil
import signal
import subprocess
import sys
from collections import deque
from pathlib import Path

REPORT_DIR_NAME = "crash-analysis"
DAILY_LIMIT = 3
DEBUG_TAIL_LINES = 3000
CLAUDE_TIMEOUT_SECONDS = 25 * 60
RUNTIME_MAX_SECONDS = CLAUDE_TIMEOUT_SECONDS + 5 * 60  # systemd's hard stop for the detached unit
STAMP_FORMAT = "%Y-%m-%d-%H%M%S"

# Claude Code may read anything and run commands, but must not edit files
# through its own editing tools. Command-level restraint is the prompt's job.
CLAUDE_ALLOWED_TOOLS = ["Bash", "Read", "Grep", "Glob", "WebFetch", "WebSearch"]
CLAUDE_DISALLOWED_TOOLS = ["Edit", "Write", "NotebookEdit"]


def is_crash(return_code, stop_requested, shutdown_marker_exists):
    """Only unrequested nonzero exits count as crashes.

    Intentional stops never do, whatever the exit status: the launcher's own
    signal handler (ctrl-c, SIGTERM), the daily restart, and host shutdown all
    announce themselves before the server goes down.
    """
    return return_code != 0 and not stop_requested and not shutdown_marker_exists


def reports_today(report_dir, now):
    """Analyses started today: one per <stamp> snapshot directory or <stamp>.md."""
    prefix = now.strftime("%Y-%m-%d")
    try:
        entries = list(report_dir.iterdir())
    except FileNotFoundError:
        return 0
    return len({entry.name.split(".")[0] for entry in entries if entry.name.startswith(prefix)})


def describe_exit(return_code):
    if return_code < 0:
        try:
            return f"killed by signal {signal.Signals(-return_code).name}"
        except ValueError:
            return f"killed by signal {-return_code}"
    if return_code > 128:
        try:
            name = signal.Signals(return_code - 128).name
            return f"exit status {return_code} (128+{return_code - 128}: possibly {name}, possibly a plain exit code)"
        except ValueError:
            pass
    return f"exit status {return_code}"


def tail_lines(source, destination, count):
    with open(source, "rb") as handle:
        last = deque(handle, maxlen=count)
    with open(destination, "wb") as handle:
        handle.writelines(last)


def snapshot(server_dir, report_dir, stamp, context):
    """Copy what the server left behind before the restart rotates it away."""
    snap = report_dir / stamp
    snap.mkdir(parents=True)
    launched = datetime.datetime.fromisoformat(context["launched_at"]).timestamp()
    logs = server_dir / "logs"
    files = []

    latest = logs / "latest.log"
    if latest.is_file():
        shutil.copy2(latest, snap / "latest.log")
        files.append("latest.log")
    debug = logs / "debug.log"
    if debug.is_file():
        tail_lines(debug, snap / "debug.log.tail", DEBUG_TAIL_LINES)
        files.append(f"debug.log.tail (last {DEBUG_TAIL_LINES} lines of logs/debug.log)")

    # Only files written during this run: older crash reports are history, not evidence.
    for pattern, subdir in (("crash-reports/*.txt", "crash-reports"), ("hs_err_pid*.log", "hs_err")):
        for path in sorted(server_dir.glob(pattern)):
            if path.is_file() and path.stat().st_mtime >= launched - 1:
                target = snap / subdir
                target.mkdir(exist_ok=True)
                shutil.copy2(path, target / path.name)
                files.append(f"{subdir}/{path.name}")

    context["snapshot_files"] = files
    (snap / "context.json").write_text(json.dumps(context, indent=2) + "\n")
    return snap


def previous_reports(report_dir, exclude_stamp, limit=5):
    names = sorted(p.name for p in report_dir.glob("*.md") if p.stem != exclude_stamp)
    return names[-limit:]


def pack_repository(server_dir):
    """update-and-start.sh is symlinked from the builder checkout that built this server."""
    link = server_dir / "update-and-start.sh"
    try:
        if link.is_symlink():
            return str(link.resolve().parent)
    except OSError:
        pass
    return None


def build_prompt(context, snap, report_dir):
    server_dir = Path(context["server_dir"])
    pack_target = server_dir / "server.nix-target"
    pack = pack_target.read_text().strip() if pack_target.is_file() else "unknown"
    repo = pack_repository(server_dir)
    files = "\n".join(f"  - {name}" for name in context.get("snapshot_files", [])) or "  - (nothing was found to snapshot)"
    previous = previous_reports(report_dir, snap.name)
    previous_text = (
        "\n".join(f"  - {REPORT_DIR_NAME}/{name}" for name in previous)
        if previous else "  - none yet"
    )
    uptime = datetime.timedelta(seconds=int(context["uptime_seconds"]))
    return f"""You are doing a post-mortem on a modded Minecraft server that just crashed. An automatic restart loop has very likely already started it again, so treat the live directory as "the server as it is now" and the snapshot as "what it looked like when it died".

# Facts

- Server directory (your working directory): {server_dir}
- Pack: {pack}. `server/` is a symlink into the Nix store holding the built server (mods, configs, launcher); `mods/`, `config/` etc. are the runtime copies.
- Pack repository (manifests, configs, build scripts): {repo or "unknown"}
- Java command line: {context["command"]}
- Started {context["launched_at"]}, exited {context["exited_at"]}, uptime {uptime}.
- Exit: {context["exit_description"]}
- Snapshot taken at exit time: {snap}/ containing:
{files}
- Earlier analyses of this server (a recurring crash is itself useful evidence; skim the newest one or two):
{previous_text}
- This is analysis {context["report_number"]} of at most {DAILY_LIMIT} for today.

# Task

Work out, as well as you reasonably can, why the server went down, and write a short report for the human operator.

# Rules

1. Read-only investigation. Do NOT modify, move, delete, or create anything in the server directory, the pack repository, the world, configs, or mods. Do NOT start, stop, restart, or signal the server, and do not run start.py, stop.sh, control.sh, update-and-start.sh, RCON, or nix builds of the pack. Do not touch systemd. You are producing suggestions; the operator decides what, if anything, to do.
2. Scratch work in a temporary directory is fine and encouraged. Use `mktemp -d`, unpack mod jars there with `unzip`, and grep or decompile the classes there. Many mods ship their sources in the jar or in a `-sources` jar; for the rest a decompiler is fine. Get tools through nix-shell rather than installing anything, e.g. `nix-shell -p unzip cfr --run 'cfr --outputdir $TMPDIR/out foo.jar'` (procyon is also available; `jar tf` comes with `nix-shell -p jdk`). Remove your temp directories when you are done.
3. "It's not obvious what broke" is an acceptable and honest conclusion. Do not invent a cause to have an answer. If several explanations are plausible, list them all with your confidence in each and what evidence would tell them apart. Giving up gracefully is a valid result.
4. Rotated logs in `logs/*.log.gz` come from earlier runs; `zcat`/`zgrep` them if you need history (e.g. to see whether this crash has happened before). Never decompress them in place.
5. Start with the crash report and the tail of the snapshot's latest.log, and go deeper (debug.log.tail, mod jars, configs, a web search for the exception) only as far as it helps. Prefer the snapshot over the live logs/, which now belong to the restarted server.

# Report format

Your final message is the report and is saved verbatim as Markdown. Use exactly these sections:

## Summary
One or two sentences: what most likely happened, or that it is unclear.

## Evidence
The key log lines and stack frames, quoted briefly, with the file each came from.

## Possible causes
Ranked, each with a confidence (high / medium / low) and the reasoning. If nothing stands out, say so plainly.

## Suggestions
Concrete things the operator could check or try. These are optional suggestions; you have not done any of them.

## What I looked at
A brief list, so the operator knows what has and has not been checked.
"""


def find_claude():
    """Prefer the real binary over the ~/bin/claude nix-shell wrapper; it skips the nix-shell start-up."""
    override = os.environ.get("CRASH_ANALYSIS_CLAUDE")
    candidates = [override] if override else []
    candidates += [str(Path.home() / ".npm-global/bin/claude"), shutil.which("claude")]
    for candidate in candidates:
        if candidate and os.access(candidate, os.X_OK):
            return candidate
    return None


def report_header(context, snap):
    server_dir = Path(context["server_dir"])
    return (
        f"# Crash analysis: {context['server_name']} {snap.name}\n\n"
        f"- Server: {server_dir}\n"
        f"- Started {context['launched_at']}, exited {context['exited_at']} "
        f"(uptime {datetime.timedelta(seconds=int(context['uptime_seconds']))})\n"
        f"- Exit: {context['exit_description']}\n"
        f"- Snapshot: {REPORT_DIR_NAME}/{snap.name}/\n"
        f"- Report {context['report_number']} of at most {DAILY_LIMIT} today. "
        f"Suggestions only: nothing was changed.\n"
    )


def write_report(snap, text):
    """Publish atomically so the prompt notice never shows a half-written report."""
    report = snap.parent / f"{snap.name}.md"
    temp = snap / "report.md.tmp"
    temp.write_text(text)
    os.replace(temp, report)
    return report


def run_analysis(server_dir, snap):
    server_dir = Path(server_dir)
    snap = Path(snap)
    context = json.loads((snap / "context.json").read_text())
    header = report_header(context, snap)
    claude = find_claude()
    if claude is None:
        write_report(snap, header + "\n**Analysis failed:** no Claude Code binary found "
                     "(looked at $CRASH_ANALYSIS_CLAUDE, ~/.npm-global/bin/claude, and PATH).\n")
        return 1

    prompt = build_prompt(context, snap, snap.parent)
    (snap / "prompt.md").write_text(prompt)
    command = [claude, "-p", "--output-format", "text", "--no-session-persistence",
               "--allowedTools", *CLAUDE_ALLOWED_TOOLS,
               "--disallowedTools", *CLAUDE_DISALLOWED_TOOLS]
    env = os.environ.copy()
    env.setdefault("HOME", str(Path.home()))
    for key in ("CLAUDECODE", "CLAUDE_CODE_ENTRYPOINT"):  # a nested session is refused
        env.pop(key, None)

    started = datetime.datetime.now()
    status = 1
    with open(snap / "claude.stderr.log", "wb") as stderr:
        try:
            completed = subprocess.run(command, input=prompt, stdout=subprocess.PIPE, stderr=stderr,
                                       text=True, cwd=server_dir, env=env, timeout=CLAUDE_TIMEOUT_SECONDS)
            status = completed.returncode
            body = completed.stdout.strip()
            if status != 0:
                body = f"**Claude Code exited with status {status}** (see {snap.name}/claude.stderr.log).\n\n{body}"
            elif not body:
                body = f"**Claude Code produced no output** (see {snap.name}/claude.stderr.log)."
        except subprocess.TimeoutExpired:
            body = f"**Analysis timed out** after {CLAUDE_TIMEOUT_SECONDS // 60} minutes (see {snap.name}/claude.stderr.log)."
        except OSError as error:
            body = f"**Analysis failed to run:** {error}"
    elapsed = datetime.timedelta(seconds=int((datetime.datetime.now() - started).total_seconds()))
    write_report(snap, f"{header}- Analysis took {elapsed}.\n\n---\n\n{body}\n")
    return status


def systemd_environment(environ=os.environ):
    """A user unit does not inherit our environment; pass on what the analyzer needs."""
    keys = ["PATH"] + sorted(key for key in environ if key.startswith("CRASH_ANALYSIS"))
    return [f"--setenv={key}={environ[key]}" for key in keys if key in environ]


def launch_background(python, server_dir, snap, unit_name, log):
    """Run `crash_analysis.py run` detached: the restart loop must not wait for it."""
    command = [python, os.path.abspath(__file__), "run", str(server_dir), str(snap)]
    if shutil.which("systemd-run"):
        systemd_command = [
            "systemd-run", "--user", "--collect", "--quiet", f"--unit={unit_name}",
            f"--working-directory={server_dir}", "-p", f"RuntimeMaxSec={RUNTIME_MAX_SECONDS}",
        ] + systemd_environment() + command
        try:
            subprocess.run(systemd_command, check=True, capture_output=True, text=True)
            return f"systemd user unit {unit_name}"
        except (OSError, subprocess.CalledProcessError) as error:
            detail = getattr(error, "stderr", "") or str(error)
            log(f"systemd-run failed ({detail.strip()}); falling back to a plain background process")
    output = open(snap / "analyzer.log", "ab")
    process = subprocess.Popen(command, cwd=server_dir, stdin=subprocess.DEVNULL,
                               stdout=output, stderr=subprocess.STDOUT, start_new_session=True)
    output.close()
    return f"background process {process.pid}"


def maybe_start_analysis(server_dir, return_code, stop_requested, shutdown_marker_exists,
                         launched_at, command, server_name, python=sys.executable,
                         log=print, now=None, launcher=launch_background):
    """Decide whether this exit deserves an analysis and, if so, kick one off.

    Returns the snapshot directory when an analysis was started, else None.
    """
    if os.environ.get("CRASH_ANALYSIS") == "0":
        return None
    if not is_crash(return_code, stop_requested, shutdown_marker_exists):
        return None
    now = now or datetime.datetime.now()
    server_dir = Path(server_dir)
    report_dir = server_dir / REPORT_DIR_NAME
    report_dir.mkdir(exist_ok=True)
    started_today = reports_today(report_dir, now)
    if started_today >= DAILY_LIMIT:
        log(f"server exited with {describe_exit(return_code)}, but {started_today} analyses "
            f"were already started today (limit {DAILY_LIMIT}); not analysing this one")
        return None

    stamp = now.strftime(STAMP_FORMAT)
    context = {
        "server_name": server_name,
        "server_dir": str(server_dir),
        "launched_at": launched_at.isoformat(timespec="seconds"),
        "exited_at": now.isoformat(timespec="seconds"),
        "uptime_seconds": (now - launched_at).total_seconds(),
        "return_code": return_code,
        "exit_description": describe_exit(return_code),
        "command": " ".join(command),
        "report_number": started_today + 1,
    }
    snap = snapshot(server_dir, report_dir, stamp, context)
    how = launcher(python, server_dir, snap, f"crash-analysis-{server_name}-{stamp}", log)
    log(f"server crashed ({context['exit_description']}); logs snapshotted to "
        f"{REPORT_DIR_NAME}/{stamp}/ and analysis started as {how}. "
        f"Report will appear at {REPORT_DIR_NAME}/{stamp}.md")
    return snap


def main(argv):
    if len(argv) == 4 and argv[1] == "run":
        return run_analysis(argv[2], argv[3])
    sys.exit(f"usage: {argv[0]} run SERVER_DIR SNAPSHOT_DIR")


if __name__ == "__main__":
    sys.exit(main(sys.argv))
