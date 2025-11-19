# Zest Documentation Site

This Hugo site provides documentation for the Zest meal planning application.

## Building the Site

### Prerequisites

- Hugo (v0.120.0 or later)
- Go (for theme modules)

### Setup

1. Install Hugo:
   ```bash
   # Windows (using chocolatey)
   choco install hugo-extended
   
   # macOS (using homebrew)
   brew install hugo
   
   # Linux (using snap)
   snap install hugo
   ```

2. Navigate to the docs directory:
   ```bash
   cd docs
   ```

3. Download theme dependencies:
   ```bash
   hugo mod get -u
   ```

### Running Locally

```bash
hugo server -D
```

The site will be available at `http://localhost:1313`

### Building for Production

```bash
hugo -D
```

The static files will be generated in the `public/` directory.

## Structure

- `content/` - Markdown content files
  - `user/` - User-facing documentation
  - `developer/` - Developer documentation
- `layouts/` - Custom Hugo layouts
- `assets/` - CSS and other assets
- `static/` - Static files (favicon, images)

## Fonts

The documentation uses:
- **Roboto Flex** - Primary font (UI and body text)
- **JetBrains Mono** - Code font

These fonts are loaded from Google Fonts via `assets/css/fonts.css`.

## Styling

The site uses the Docsy theme, which provides a professional documentation layout.

### Features

- Dark mode toggle
- Search functionality
- Table of contents
- Breadcrumb navigation
- Syntax highlighting
- Responsive design
