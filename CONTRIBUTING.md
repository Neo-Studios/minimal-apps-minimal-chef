# Contributing to Zest

Thank you for your interest in contributing to Zest! This document provides guidelines for contributing to the project.

## Code of Conduct

- Be respectful and inclusive
- Provide constructive feedback
- Focus on what is best for the community
- Show empathy towards other contributors

## How to Contribute

### Reporting Bugs

1. Check if the bug has already been reported in Issues
2. If not, create a new issue with:
   - Clear, descriptive title
   - Steps to reproduce
   - Expected vs actual behavior
   - Screenshots if applicable
   - Device/platform information
   - Flutter and Dart versions

### Suggesting Features

1. Check if the feature has been suggested
2. Create a new issue with:
   - Clear description of the feature
   - Use cases and benefits
   - Possible implementation approach

### Pull Requests

1. Fork the repository
2. Create a feature branch: `git checkout -b feature/your-feature-name`
3. Follow the coding standards (see below)
4. Commit your changes with clear messages
5. Push to your fork
6. Submit a pull request

## Development Setup

```bash
# Clone the repository
git clone https://github.com/neo-studios/zest.git
cd zest

# Install dependencies
flutter pub get

# Setup Firebase (see lib/FIREBASE_SETUP.md)
# Add your firebase_options.dart

# Run the app
flutter run
```

## Coding Standards

### Follow Project Guidelines

Refer to `.amazonq/rules/memory-bank/guidelines.md` for:

- Naming conventions
- File organization
- Widget structure
- State management patterns
- UI/UX patterns

### Key Principles

- **Classes**: PascalCase (e.g., `RecipeService`)
- **Files**: snake_case (e.g., `recipe_service.dart`)
- **Variables/Methods**: camelCase (e.g., `getUserRecipes`)
- **Private members**: Prefix with underscore (e.g., `_auth`)
- Use `const` constructors wherever possible
- Prefer `StatelessWidget` for static UI
- Minimal inline comments - code should be self-explanatory

### Before Submitting

1. Run `flutter analyze` - must pass with no issues
2. Format code: `dart format .`
3. Test on multiple platforms if possible
4. Update documentation if needed
5. Add yourself to contributors list

## Project Structure

```dir
lib/
├── features/          # Feature modules
│   ├── auth/         # Authentication
│   ├── recipe/       # Recipe management
│   ├── meal_plan/    # Meal planning
│   └── shopping_list/
├── core/             # Core services
├── data/             # Static data & database
└── main.dart
```

## Testing

- Write tests for new features
- Ensure existing tests pass
- Test on multiple screen sizes
- Test both light and dark themes

## License

By contributing, you agree that your contributions will be licensed under the Neo Studios Public Repository License (see LICENSE.md).

## Questions?

Feel free to open an issue for any questions about contributing!
