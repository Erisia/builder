# Website Modernization Plan

## Current Setup
- Jekyll (Ruby-based static site generator)
- Simple structure with pages in `_pages/` directory
- Bootstrap CSS for styling

## Recommended Replacement: Hugo

### Why Hugo?
1. **Speed** - Extremely fast build times
2. **Single Binary** - No runtime dependencies (vs Ruby for Jekyll)
3. **Nix Integration** - Works well in Nix environments
4. **Theming** - Extensive theme ecosystem
5. **Modern Features** - Asset pipelines, ESM, Tailwind integration

### Migration Steps

1. **Install Hugo**
   - Add to `default.nix` or use a Hugo flake

2. **Migrate Content**
   - Convert Jekyll pages to Hugo pages
   - Move `_pages/*.html` to `content/*.md` with frontmatter
   - Convert layouts to Hugo templates

3. **Setup Hugo Configuration**
   - Create `config.toml` or `hugo.yaml`
   - Configure menu structure

4. **Modernize Styling**
   - Upgrade Bootstrap or switch to Tailwind CSS

5. **Enhance CI/CD**
   - Update build script
   - Utilize Nix for reproducible builds

### Example Configuration

```yaml
# hugo.yaml
baseURL: "https://erisia.example.com/"
title: "Erisia Minecraft Server"
theme: "erisia-theme"

params:
  description: "Erisia Minecraft Server community website"

menu:
  main:
    - name: "Home"
      url: "/"
      weight: 1
    - name: "Getting Started"
      url: "/getting-started/"
      weight: 2
    # Add other menu items
```

### Example Build Script

```bash
#!/usr/bin/env nix-shell
#!nix-shell -i bash -p hugo

set -e
cd $(dirname $0)
hugo server -D
```

### Example Nix Build

```nix
{ pkgs ? import <nixpkgs> {} }:

pkgs.stdenv.mkDerivation {
  name = "erisia-website";
  src = ./.;
  
  buildInputs = [ pkgs.hugo ];
  
  buildPhase = ''
    hugo --minify
  '';
  
  installPhase = ''
    cp -r public $out
  '';
}
```

### Optional Enhancements
1. Add search functionality
2. Implement dark mode
3. Add dynamic mod list fetching from manifest
4. Improve responsive design
5. Add interactive server status indicator