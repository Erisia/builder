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

## Migration from Jekyll

This is a modern replacement for the original Jekyll-based site. To complete the migration:

1. Convert all remaining pages from `web/_pages/*.html` to Markdown in `web-hugo/content/*.md`
2. Copy any additional assets from `web/img/` to `web-hugo/static/img/`
3. Update any custom includes or layouts as needed
4. Test thoroughly to ensure all functionality works as expected

## Structure

- `content/` - Markdown content files
- `layouts/` - HTML templates
- `static/` - Static assets (CSS, JS, images)
- `hugo.yaml` - Site configuration

## Deployment

Update the main `default.nix` file to reference this directory instead of the Jekyll site.