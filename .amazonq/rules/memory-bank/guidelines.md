# Development Guidelines

## Code Quality Standards

### Naming Conventions
- **Classes**: PascalCase (e.g., `Recipe`, `AuthService`, `SpringyButton`)
- **Files**: snake_case matching class names (e.g., `auth_service.dart`, `springy_button.dart`)
- **Variables/Methods**: camelCase (e.g., `_selectedIndex`, `signInWithGoogle`)
- **Private members**: Prefix with underscore (e.g., `_auth`, `_controller`, `_isSidebarVisible`)
- **Constants**: camelCase with `const` keyword (e.g., `const HomeScreen()`)

### File Organization
- One primary class per file
- File name matches the main class in snake_case
- Imports grouped: Flutter SDK, external packages, internal imports
- Models in `/models`, services in `/services`, screens in `/screens`, widgets in `/widgets`

### Documentation
- Minimal inline comments - code should be self-explanatory
- Comments used for clarification (e.g., "// The user canceled the sign-in")
- Important notes highlighted (e.g., "// Note: No duration!", "// This is the key property!")

## Architectural Patterns

### Widget Structure
- Prefer `StatelessWidget` for static UI (e.g., `AuthGate`)
- Use `StatefulWidget` for interactive components (e.g., `HomeScreen`, `SpringyButton`)
- Always use `const` constructors when possible
- Named parameters with `required` keyword for mandatory fields
- Optional parameters use nullable types (e.g., `String?`, `int?`)

### State Management
- Local state with `setState()` for UI-specific state
- `StreamBuilder` for reactive Firebase data (e.g., auth state changes)
- Private state variables prefixed with underscore

### Service Layer Pattern
```dart
class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  
  Stream<User?> get user {
    return _auth.authStateChanges();
  }
  
  Future<User?> signInWithGoogle() async {
    // Implementation
  }
}
```
- Services are stateless classes
- Firebase instances as private final fields
- Async operations return `Future<T>` or `Stream<T>`
- Error handling with try-catch, returning null on failure

### Data Models
```dart
class Recipe {
  final String? id;
  final String name;
  
  Recipe({
    this.id,
    required this.name,
  });
  
  Map<String, dynamic> toMap() { }
  factory Recipe.fromMap(Map<String, dynamic> map, String id) { }
}
```
- Immutable models with `final` fields
- Optional `id` field (nullable) for Firestore documents
- `toMap()` for serialization (excludes id)
- `factory` constructors for deserialization
- Null-safe with `??` operators for defaults

## UI/UX Patterns

### Responsive Design
```dart
final isDesktop = MediaQuery.of(context).size.width >= 600;
```
- Breakpoint at 600px for desktop/mobile
- Desktop: NavigationRail sidebar + top AppBar
- Mobile: BottomNavigationBar
- Conditional rendering with ternary operators

### Theme Usage
```dart
final theme = Theme.of(context);
theme.colorScheme.surface
theme.textTheme.headlineMedium
```
- Always access theme through `Theme.of(context)`
- Use Material 3 color scheme properties
- Apply RobotoFlex text styles from theme

### Navigation
- `Navigator.push()` with `MaterialPageRoute` for screen transitions
- Pass context and builder function
- Use `const` for screen constructors

### Icons
- Outlined icons for unselected state (e.g., `Icons.explore_outlined`)
- Filled icons for selected state (e.g., `Icons.explore`)
- Consistent icon usage across navigation elements

## Animation Patterns

### Physics-Based Animation
```dart
class _SpringyButtonState extends State<SpringyButton>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late SpringSimulation _simulation;
  
  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      lowerBound: double.negativeInfinity,
      upperBound: double.infinity,
    );
    _controller.addListener(() {
      setState(() { /* update UI */ });
    });
  }
}
```
- Use `SingleTickerProviderStateMixin` for animations
- `late` keyword for controller initialization in `initState()`
- Always dispose controllers in `dispose()`
- `SpringSimulation` for natural physics-based motion

### Implicit Animations
```dart
AnimatedDefaultTextStyle(
  duration: const Duration(milliseconds: 400),
  curve: Curves.easeInOut,
  style: TextStyle(/* animated properties */),
  child: const Text('Content'),
)
```
- Prefer implicit animations (e.g., `AnimatedDefaultTextStyle`)
- Standard duration: 400ms
- Use `Curves.easeInOut` for smooth transitions

### Variable Fonts
```dart
TextStyle(
  fontFamily: 'RobotoFlex',
  fontVariations: [
    FontVariation('wght', weight),
  ],
)
```
- Use `fontVariations` for RobotoFlex weight animation
- Weight range: 100-1000

## Firebase Integration

### Authentication
- Use `FirebaseAuth.instance` for auth operations
- Stream-based auth state with `authStateChanges()`
- Google Sign-In integration with credential flow
- Always sign out from both Firebase and Google

### Firestore
```dart
_db.collection('recipes').snapshots().map((snapshot) =>
  snapshot.docs.map((doc) => Recipe.fromMap(doc.data(), doc.id)).toList()
)
```
- Use `snapshots()` for real-time streams
- Use `add()` for creating documents (auto-generated ID)
- Pass document ID separately to `fromMap()` factory
- Map Firestore data to model objects immediately

## Error Handling
- Try-catch blocks for async operations
- Return `null` on errors for optional results
- Use null-aware operators (`??`, `?.`) throughout
- Provide default values in model factories

## Code Style
- No trailing commas in short parameter lists
- Trailing commas for multi-line parameter lists
- Prefer expression bodies for simple getters
- Use `const` constructors wherever possible
- Explicit type annotations for clarity
