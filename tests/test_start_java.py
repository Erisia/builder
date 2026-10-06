"""start.py's choice of JDK: the pack's pinned bin/java, else `nix shell`."""

import os
import tempfile
import unittest
from pathlib import Path

from test_daily_restart import load_start


class JavaLaunchTests(unittest.TestCase):
    def setUp(self):
        self.dir = Path(self.enterContext(tempfile.TemporaryDirectory()))
        self.start = load_start(self.dir)
        self.server = self.dir / "server"
        (self.server / "bin").mkdir(parents=True)
        self.command = ["java", "-Xmx1G", "-jar", "cleanroom.jar", "nogui"]

    def test_pinned_jdk_is_used_directly_and_put_on_path(self):
        jdk_bin = self.dir / "jdk" / "lib" / "openjdk" / "bin"
        jdk_bin.mkdir(parents=True)
        (jdk_bin / "java").write_text("")
        os.symlink(jdk_bin / "java", self.server / "bin" / "java")

        command, env, source = self.start.java_launch(
            self.server, "jdk25", self.command, {"PATH": "/usr/bin", "HOME": "/h"})

        self.assertEqual(command, [str(self.server / "bin/java"), *self.command[1:]])
        self.assertEqual(env["PATH"], f"{jdk_bin.resolve()}{os.pathsep}/usr/bin")
        self.assertEqual(env["HOME"], "/h")
        self.assertIn("pinned", source)

    def test_without_a_pin_falls_back_to_nix_shell(self):
        env_in = {"PATH": "/usr/bin"}
        command, env, _ = self.start.java_launch(self.server, "jdk25", self.command, env_in)
        self.assertEqual(command, ["nix", "shell", "nixpkgs#jdk25", "--command", *self.command])
        self.assertEqual(env, env_in)

    def test_scripts_like_run_sh_are_not_redirected(self):
        (self.server / "bin" / "java").write_text("")
        command, _, _ = self.start.java_launch(self.server, "jre", ["/srv/run.sh"], {})
        self.assertEqual(command, ["nix", "shell", "nixpkgs#jre", "--command", "/srv/run.sh"])


if __name__ == "__main__":
    unittest.main()
