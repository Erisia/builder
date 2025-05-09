# Erisia Website (Hugo Version)

Modern website for the Erisia Minecraft server using Hugo static site generator.

## Getting Started

### Prerequisites
- [Nix](https://nixos.org/) (or standalone [Hugo](https://gohugo.io/))

### Development

Run the local development server:
```
./serve.sh
```

Or if you have Hugo installed directly:
```
hugo server
```

The site will be available at http://localhost:1313

### Building

Build the static site:
```
nix-build
```

The built site will be in the `result` directory.

## Structure

- `content/` - Markdown content files
- `layouts/` - HTML templates
- `static/` - Static assets (CSS, JS, images)
- `hugo.yaml` - Site configuration

## Deployment

Update the main `default.nix` file to reference this directory instead of the Jekyll site.
