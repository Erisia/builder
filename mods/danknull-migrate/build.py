#!/usr/bin/env python3
"""Build against a pinned, installed Cleanroom launcher; no Gradle/Maven downloads.

Minecraft classes are not on the launcher classpath (they are binpatched at runtime), so src/stubs holds
compile-only stand-ins with the runtime (SRG) member names. They are not packaged.
"""
import argparse
import os
from pathlib import Path
import shutil
import subprocess
import zipfile

ROOT = Path(__file__).resolve().parent
VERSION = "1.0.0"
NAME = "erisia-danknull-migrate"


def javac_run(javac, classpath, sources, out):
    if out.exists():
        shutil.rmtree(out)
    out.mkdir(parents=True)
    subprocess.run([javac, "--release", "8", "-proc:none", "-encoding", "UTF-8",
                    "-classpath", classpath, "-d", str(out), *map(str, sources)], check=True)


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("--launcher", required=True, type=Path,
                        help="Cleanroom 0.6.12-alpha directory containing launcher jar and libraries")
    parser.add_argument("--java-home", type=Path, default=os.environ.get("JAVA_HOME"))
    parser.add_argument("--output", type=Path, default=ROOT / "build")
    args = parser.parse_args()
    launcher = args.launcher.resolve()
    if not (launcher / "cleanroom-0.6.12-alpha.jar").is_file():
        parser.error("Expected cleanroom-0.6.12-alpha.jar; other versions are not validated")
    javac = str(args.java_home / "bin/javac") if args.java_home else shutil.which("javac")
    if not javac:
        parser.error("A JDK is required (set JAVA_HOME or --java-home)")
    jars = [launcher / "cleanroom-0.6.12-alpha.jar", *sorted((launcher / "libraries").rglob("*.jar"))]
    classpath = os.pathsep.join(map(str, jars))
    args.output.mkdir(parents=True, exist_ok=True)
    stubs = args.output / "stub-classes"
    javac_run(javac, classpath, sorted((ROOT / "src/stubs/java").rglob("*.java")), stubs)
    classes = args.output / "main-classes"
    javac_run(javac, classpath + os.pathsep + str(stubs), sorted((ROOT / "src/main/java").rglob("*.java")), classes)
    jar = args.output / f"{NAME}-{VERSION}.jar"
    # Stable zip metadata keeps repeated builds byte-identical.
    with zipfile.ZipFile(jar, "w", zipfile.ZIP_DEFLATED) as archive:
        def add(name, data):
            archive.writestr(zipfile.ZipInfo(name, (1980, 1, 1, 0, 0, 0)), data)
        add("META-INF/MANIFEST.MF", b"Manifest-Version: 1.0\n\n")
        for directory in (classes, ROOT / "src/main/resources"):
            for path in sorted(directory.rglob("*")):
                if path.is_file():
                    add(str(path.relative_to(directory)), path.read_bytes())
    print(jar, flush=True)


if __name__ == "__main__":
    main()
