#!/usr/bin/env python3
"""Build against a pinned, installed Cleanroom launcher; no Gradle/Maven downloads."""
import argparse
import os
from pathlib import Path
import shutil
import subprocess
import zipfile

ROOT = Path(__file__).resolve().parent
VERSION = "0.1.0"


def compile_jar(javac, classpath, source_set, output, plugin):
    classes = output / (source_set + "-classes")
    if classes.exists():
        shutil.rmtree(classes)
    classes.mkdir(parents=True)
    sources = sorted((ROOT / "src" / source_set / "java").rglob("*.java"))
    subprocess.run([javac, "--release", "8", "-proc:none", "-encoding", "UTF-8",
                    "-classpath", classpath, "-d", str(classes), *map(str, sources)], check=True)
    name = "erisia-live-inspector" + ("-tests" if source_set == "test" else "")
    jar = output / f"{name}-{VERSION}.jar"
    manifest = ("Manifest-Version: 1.0\n"
                f"FMLCorePlugin: {plugin}\n"
                + "FMLCorePluginContainsFMLMod: true\n" + "\n")
    # Stable zip metadata keeps repeated builds byte-identical.
    with zipfile.ZipFile(jar, "w", zipfile.ZIP_DEFLATED) as archive:
        def add(name, data):
            archive.writestr(zipfile.ZipInfo(name, (1980, 1, 1, 0, 0, 0)), data)
        add("META-INF/MANIFEST.MF", manifest.encode())
        for directory in (classes, ROOT / "src" / source_set / "resources"):
            for path in sorted(directory.rglob("*")):
                if path.is_file():
                    add(str(path.relative_to(directory)), path.read_bytes())
    print(jar, flush=True)
    return jar


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("--launcher", required=True, type=Path,
                        help="Cleanroom 0.6.12-alpha directory containing launcher jar and libraries")
    parser.add_argument("--java-home", type=Path, default=os.environ.get("JAVA_HOME"))
    parser.add_argument("--output", type=Path, default=ROOT / "build")
    parser.add_argument("--with-tests", action="store_true")
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
    main_jar = compile_jar(javac, classpath, "main", args.output,
                           "org.erisia.inspect.InspectorPlugin")
    if args.with_tests:
        compile_jar(javac, classpath + os.pathsep + str(main_jar), "test", args.output,
                    "org.erisia.inspecttest.TestPlugin")


if __name__ == "__main__":
    main()
