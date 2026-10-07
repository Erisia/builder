# packwiz-installer, built from pinned source: the program a Prism instance runs before every launch
# to sync itself to the published packwiz index (lib/prism.nix).
#
# Produces: $out/share/java/packwiz-installer.jar, byte-identical in content to upstream's v0.5.14
#   release jar (checked 2026-10-07, together with a source and dependency review; see board #12).
# Inputs: the upstream tag, deps.json (every Gradle dependency, pinned by hash; regenerate with
#   `nix build .#packwiz-installer.mitmCache.updateScript && ./result`), and nix-build.patch, which
#   drops the build plugins that need .git or network (git-version, github-release, license report).
# Consumers: lib/prism.nix puts the jar in the Prism instance zip. It's run directly
#   (`-cp … link.infra.packwiz.installer.Main`), never through packwiz-installer-bootstrap, whose
#   self-update would replace this jar with an unchecked download from GitHub.
{
  lib,
  stdenv,
  fetchFromGitHub,
  gradle_8,
  jdk17,
}:
let
  # Kotlin 1.7.10 and Gradle-7-era plugins: Gradle 8 on JDK 17 builds it.
  gradle = gradle_8.override { java = jdk17; };
in
stdenv.mkDerivation (finalAttrs: {
  pname = "packwiz-installer";
  version = "0.5.14";

  src = fetchFromGitHub {
    owner = "packwiz";
    repo = "packwiz-installer";
    tag = "v${finalAttrs.version}";
    hash = "sha256-Bryi+v5cshwnrBEJUU/mJ2mg5sHbqOYwdvuhqR6T5os=";
  };

  patches = [ ./nix-build.patch ];

  nativeBuildInputs = [ gradle ];

  mitmCache = gradle.fetchDeps {
    pkg = finalAttrs.finalPackage;
    data = ./deps.json;
  };

  gradleFlags = [
    "-PpackwizVersion=v${finalAttrs.version}"
    "-Dfile.encoding=utf-8"
  ];
  # shadowJar, then R8's shrinkJar, then distJar: build/dist/packwiz-installer.jar, as upstream releases it.
  gradleBuildTask = "copyJar";

  installPhase = ''
    runHook preInstall
    install -Dm644 build/dist/packwiz-installer.jar $out/share/java/packwiz-installer.jar
    runHook postInstall
  '';

  meta = {
    description = "Installer for packwiz modpacks";
    homepage = "https://github.com/packwiz/packwiz-installer";
    license = lib.licenses.mit;
  };
})
