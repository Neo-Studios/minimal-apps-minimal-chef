---
layout: page
title: Contributing
permalink: /contributing/
---

# Contributing Guide

## Development Setup

1. **Fork and clone**
   ```bash
   git clone https://github.com/YOUR_USERNAME/minimal-chef.git
   cd minimal-chef
   ```

2. **Install dependencies**
   ```bash
   npm install
   ```

3. **Create feature branch**
   ```bash
   git checkout -b feature/your-feature-name
   ```

4. **Start development**
   ```bash
   npm start
   ```

## Project Structure

```
minimal-chef/
├── src/
│   ├── components/     # Reusable UI components
│   ├── contexts/       # React contexts (Auth, Debug)
│   ├── hooks/          # Custom React hooks
│   ├── pages/          # Page components
│   ├── types/          # TypeScript type definitions
│   └── utils/          # Utility functions
├── api/                # Serverless API functions
├── public/             # Static assets
└── docs/               # Jekyll documentation
```

## Coding Standards

### TypeScript
- Use strict TypeScript configuration
- Define interfaces for all data structures
- Avoid `any` types

### React
- Use functional components with hooks
- Follow Material-UI design patterns
- Implement responsive design

### Styling
- Use Material-UI's `sx` prop for styling
- Follow the design system colors:
  - Light mode: `#EADDCB`
  - Dark mode: `#203141`
- Typography: Times New Roman for headings, Noto Sans for body

## Testing

### Debug Mode
Enable debug mode for testing:
```javascript
// In browser console
debug("--on")
```

### Recipe Import Testing
Test recipe import with various websites:
- AllRecipes
- Food Network
- Personal blogs
- International sites

## Pull Request Process

1. **Update documentation** if needed
2. **Test thoroughly** on desktop and mobile
3. **Follow commit message format**:
   ```
   feat: add recipe timer feature
   fix: resolve authentication bug
   docs: update API documentation
   ```

4. **Create pull request** with:
   - Clear description of changes
   - Screenshots for UI changes
   - Testing instructions

## Issue Guidelines

### Bug Reports
Include:
- Steps to reproduce
- Expected vs actual behavior
- Browser and device information
- Screenshots if applicable

### Feature Requests
Include:
- Clear use case description
- Proposed implementation approach
- Mockups or examples if helpful

## Code Review

All contributions require code review. Reviewers will check:
- Code quality and standards
- Functionality and testing
- Documentation updates
- Design consistency

## Community

- Be respectful and inclusive
- Help others learn and contribute
- Follow the [Code of Conduct](../CODE_OF_CONDUCT.md)
- Ask questions in GitHub issues

## Recognition

Contributors are recognized in:
- GitHub contributors list
- Release notes for significant contributions
- Documentation acknowledgments