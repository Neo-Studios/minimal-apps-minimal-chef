# Zest Documentation Site

Complete Hugo documentation site for the Zest meal planning application.

## Overview

This is a professional documentation site built with [Hugo](https://gohugo.io/) and the [Docsy](https://www.docsy.dev/) theme. It provides comprehensive documentation for both users and developers.

## Features

✨ **Professional Design** - Built with the modern Docsy theme  
🎨 **Custom Fonts** - Roboto Flex (primary) and JetBrains Mono (code)  
🌙 **Dark Mode** - Full dark mode support  
🔍 **Search** - Built-in search functionality  
📱 **Responsive** - Mobile-friendly design  
🌐 **Multi-language Ready** - Setup for internationalization  
📊 **Analytics Ready** - Google Analytics integration  
🎯 **SEO Optimized** - Includes meta tags and sitemaps  

## Documentation Structure

```
content/
├── _index.md           # Homepage
├── user/               # User documentation
│   ├── _index.md
│   ├── getting-started.md
│   ├── recipes.md
│   ├── meal-planner.md
│   └── shopping-list.md
└── developer/          # Developer documentation
    ├── _index.md
    ├── backend.md
    ├── web.md
    ├── ios.md
    └── android.md
```

## Quick Start

### Prerequisites

- Hugo Extended (v0.120.0 or later)
- Go 1.20+ (for theme modules)
- Git

### Installation

#### macOS (with Homebrew)
```bash
brew install hugo
```

#### Windows (with Chocolatey)
```bash
choco install hugo-extended
```

#### Ubuntu/Debian
```bash
sudo apt-get install hugo
```

#### From Source
```bash
# See https://gohugo.io/getting-started/installing/
```

### Running Locally

1. Navigate to the docs directory:
```bash
cd docs
```

2. Install Hugo module dependencies:
```bash
hugo mod get -u
```

3. Start the development server:
```bash
hugo server -D
```

4. Open your browser to `http://localhost:1313`

### Building for Production

```bash
hugo -D
```

The built site will be in the `public/` directory.

## Fonts

This site uses:

- **Roboto Flex** - Primary font for all text and UI elements
  - Features variable font axes for flexible styling
  - Loaded from Google Fonts
  - Used for body text, headings, and navigation

- **JetBrains Mono** - Code and monospace font
  - Professional monospace font for code blocks
  - Loaded from Google Fonts
  - Used for `<code>`, `<pre>`, and syntax highlighting

Both fonts are imported in `layouts/baseof.html` and configured in `assets/css/fonts.css`.

## Customization

### Colors

Edit `assets/css/custom.css` to customize colors:

```css
:root {
  --color-primary: #FF6B35;
  --color-secondary: #004E89;
  --color-accent: #F77F00;
}
```

### Configuration

Main configuration is in `hugo.toml`:

- **baseURL** - Set this to your site's URL
- **title** - Site title
- **params.docsy** - Theme parameters
- **menu** - Navigation menu items

### Theme Options

The Docsy theme is configured via `[params.docsy]` in `hugo.toml`. Key options:

- `dark_mode` - Enable/disable dark mode toggle
- `search` - Enable/disable search
- `toc` - Enable/disable table of contents
- `breadcrumbs` - Enable/disable breadcrumb navigation
- `edit_page` - Enable/disable "Edit this page" links
- `syntax_highlighting_theme` - Choose syntax highlighting style

## Content Guidelines

### Front Matter

All markdown files should start with YAML front matter:

```yaml
---
title: Page Title
description: Brief description for SEO
weight: 10  # Lower numbers appear first
---
```

### Headings

Use proper heading hierarchy:
- `# ` for page title (set in front matter)
- `## ` for main sections
- `### ` for subsections
- `#### ` for sub-subsections

### Code Blocks

Use fenced code blocks with language specification:

````markdown
```python
def hello_world():
    print("Hello, World!")
```
````

### Links

Use relative links within the site:

```markdown
[Link text](/path/to/page/)
```

## Deployment

### GitHub Pages

Add this to `.github/workflows/deploy.yml`:

```yaml
name: Deploy Hugo Site

on:
  push:
    branches: [main]

jobs:
  deploy:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v3
      - uses: peaceiris/actions-hugo@v4
        with:
          hugo-version: 'latest'
      - run: cd docs && hugo
      - uses: peaceiris/actions-gh-pages@v3
        with:
          github_token: ${{ secrets.GITHUB_TOKEN }}
          publish_dir: ./docs/public
```

### Netlify

1. Connect your GitHub repository
2. Set build command: `cd docs && hugo`
3. Set publish directory: `docs/public`

### Vercel

1. Import project from GitHub
2. Framework: Hugo
3. Build command: `cd docs && hugo`
4. Output directory: `docs/public`

## Troubleshooting

### Module not found error
```bash
hugo mod get -u
```

### Port already in use
```bash
hugo server -D -p 8080
```

### Changes not appearing
- Clear cache: `rm -rf resources/_gen/`
- Restart server

## Contributing

To add new documentation:

1. Create a new `.md` file in the appropriate `content/` directory
2. Add front matter with title, description, and weight
3. Write content in Markdown
4. Test locally with `hugo server -D`
5. Submit a pull request

## Styling

### CSS Files

- `assets/css/fonts.css` - Font configuration and typography
- `assets/css/custom.css` - Custom styles and theme overrides

### Docsy Theme

Full Docsy documentation: https://www.docsy.dev/

## Resources

- [Hugo Documentation](https://gohugo.io/documentation/)
- [Docsy Theme](https://www.docsy.dev/)
- [Markdown Guide](https://www.markdownguide.org/)
- [Google Fonts](https://fonts.google.com/)

## License

This documentation is part of the Zest project. See the main LICENSE.md file.

## Support

For issues or questions:
- Open an issue on [GitHub](https://github.com/neostudios/zest/issues)
- Check the [Docsy FAQ](https://www.docsy.dev/docs/getting-started/faq/)
