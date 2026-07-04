# assets

Source art for pack branding (not consumed by the Nix build).

## Military pack icon

- `military-icon.svg` / `military-icon.png` — the **live** Modrinth icon for the
  `military` ("Kids Military Games") pack: a military-insignia medallion (Create-style cog
  ring around a badge with a central **olive-green star**). 512×512.
- `gen.py` — regenerates the icon and its variants from hand-written SVG, rasterized via
  `cairosvg`. Run `python3 gen.py` (needs `pip install cairosvg`). It emits three candidates:
  1 = gold star, 2 = gold star + rank chevron, 3 = green star. **Candidate 3 is the one in
  use** — tweak colours/geometry there and re-copy `military-icon-3.*` over the live files.

Uploaded to Modrinth via `PATCH /v2/project/<id>/icon?ext=png`.
