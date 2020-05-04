import (builtins.fetchTarball {
  # Descriptive name to make the store path easier to identify
  name = "nixos-minecraft";
  # Commit hash for nixos-20.03 as of 2020-05-03
  # Obtained from https://status.nixos.org/
  url = https://github.com/nixos/nixpkgs/archive/ab3adfe1c769c22b6629e59ea0ef88ec8ee4563f.tar.gz;
  # Hash obtained using `nix-prefetch-url --unpack <url>`
  sha256 = "1m4wvrrcvif198ssqbdw897c8h84l0cy7q75lyfzdsz9khm1y2n1";
})
