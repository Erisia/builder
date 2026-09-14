#!/usr/bin/env python3
"""Stop this user's builder-managed servers; run under a bounded systemd unit."""

import argparse
from contextlib import ExitStack
import os
from pathlib import Path
import select
import subprocess


def running_servers(home, stack):
    """Pin live start.py processes, ignoring stale or reused server.pid files."""
    servers = []
    for pid_file in sorted(home.glob("*/server.pid")):
        world = pid_file.parent.resolve()
        try:
            pid = int(pid_file.read_text().strip())
            if pid <= 0:
                continue
            descriptor = os.pidfd_open(pid)
            stack.callback(os.close, descriptor)
            process = Path(f"/proc/{pid}")
            command = (process / "cmdline").read_bytes().split(b"\0")
            if (process.stat().st_uid == os.getuid()
                    and len(command) > 1
                    and command[1] == os.fsencode(world / "server/start.py")):
                servers.append((world, descriptor))
        except (OSError, ValueError) as error:
            print(f"{world.name}: ignoring stale/unreadable PID file: {error}", flush=True)
    return servers


def shutdown(home, marker, grace):
    # /run/user is discarded at reboot. Leave the marker in place even on
    # failure, so the five-second restart loop cannot undo the stop request.
    marker.touch(mode=0o600, exist_ok=True)
    # Block launches before discovery so a restart cannot slip past the scan.
    with ExitStack() as stack:
        stop_servers(running_servers(home, stack), grace)


def stop_servers(servers, grace):
    controls = []
    for world, descriptor in servers:
        if select.select([descriptor], [], [], 0)[0]:
            continue
        print(f"{world.name}: requesting shutdown ({grace}s warning)", flush=True)
        try:
            # Bypass stop.sh's --lazy uptime guard. Each world's wrapper knows
            # the argument convention of its bundled control binary.
            controls.append((world, subprocess.Popen(
                [str(world / "control.sh"), "stop", "-t", str(grace)], cwd=world,
            )))
        except OSError as error:
            print(f"{world.name}: could not run control.sh: {error}", flush=True)

    for world, control in controls:
        status = control.wait()
        if status:
            print(f"{world.name}: control exited with status {status}", flush=True)

    # A failed control command must not release the gate while a server still
    # runs. pidfds track the original process even if its PID is later reused.
    pending = {descriptor: world for world, descriptor in servers}
    while pending:
        exited, _, _ = select.select(list(pending), [], [])
        for descriptor in exited:
            print(f"{pending.pop(descriptor).name}: stopped", flush=True)


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("--list", action="store_true", help="list running servers without stopping them")
    parser.add_argument("--grace", type=int, default=10, help="player warning in seconds (default: 10)")
    args = parser.parse_args()
    if args.grace < 0:
        parser.error("--grace must be nonnegative")
    if args.list:
        with ExitStack() as stack:
            for world, _ in running_servers(Path.home(), stack):
                print(world)
    else:
        shutdown(Path.home(), Path(f"/run/user/{os.getuid()}/minecraft-shutdown"), args.grace)


if __name__ == "__main__":
    main()
