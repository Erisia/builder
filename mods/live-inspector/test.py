#!/usr/bin/env python3
"""Run deterministic tests in a fresh, disposable Cleanroom server (never the live world)."""
import argparse
import os
from pathlib import Path
import shutil
import subprocess
import tempfile

from build import ROOT, VERSION


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("--launcher", type=Path, required=True)
    parser.add_argument("--java-home", type=Path, default=os.environ.get("JAVA_HOME"))
    parser.add_argument("--build", type=Path, default=ROOT / "build")
    parser.add_argument("--work-dir", type=Path, help="must not already exist; default is a new temporary directory")
    args = parser.parse_args()
    launcher = args.launcher.resolve()
    java = str(args.java_home / "bin/java") if args.java_home else shutil.which("java")
    if not java:
        parser.error("Java 25 is required")
    if args.work_dir:
        work = args.work_dir.resolve()
        work.mkdir(parents=True, exist_ok=False)
    else:
        work = Path(tempfile.mkdtemp(prefix="erisia-live-inspector-test-"))
    (work / "mods").mkdir()
    test_jar = args.build / f"erisia-live-inspector-tests-{VERSION}.jar"
    shutil.copy2(test_jar, work / "mods" / test_jar.name)
    fix_jar = args.build / f"erisia-live-inspector-{VERSION}.jar"
    shutil.copy2(fix_jar, work / "mods" / fix_jar.name)
    (work / "libraries").symlink_to(launcher / "libraries", target_is_directory=True)
    (work / "eula.txt").write_text("eula=true\n")
    (work / "server.properties").write_text(
        "server-ip=127.0.0.1\nserver-port=0\nonline-mode=false\nenable-rcon=false\n"
        "enable-query=false\nlevel-name=test-world\nlevel-type=FLAT\n"
        "generator-settings=3;minecraft:bedrock;1;\nview-distance=2\n"
        "spawn-protection=0\nspawn-animals=false\nspawn-monsters=false\nspawn-npcs=false\n"
        "generate-structures=false\nmax-tick-time=30000\n")
    command = [java, "-Xms256m", "-Xmx1g", "-Djava.net.preferIPv4Stack=true",
               "-Dfml.queryResult=confirm", "-Dmixin.debug.export=true", "-Dmixin.debug.countInjections=true",
               "-jar", str(launcher / "cleanroom-0.6.12-alpha.jar"), "nogui"]
    print(f"Test directory: {work}", flush=True)
    with (work / "console.log").open("w") as log:
        try:
            result = subprocess.run(command, cwd=work, stdin=subprocess.DEVNULL, stdout=log,
                                    stderr=subprocess.STDOUT, timeout=180)
        except subprocess.TimeoutExpired:
            print("FAIL: test server exceeded 180 seconds; inspect console.log", flush=True)
            return 1
    marker = work / "test-result.txt"
    status = marker.read_text().strip() if marker.exists() else "FAIL: no test result (startup failed)"
    print(status, flush=True)
    if result.returncode or status != "PASS":
        print("\n".join((work / "console.log").read_text(errors="replace").splitlines()[-70:]))
        return 1
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
