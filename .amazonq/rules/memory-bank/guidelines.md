# Development Guidelines - Minimal Chef

## Code Quality Standards

### Formatting & Style
- **Dart Style**: Follow official Dart style guide with flutter_lints ^6.0.0
- **Line Length**: Keep lines readable, typically under 80-100 characters
- **Indentation**: 2 spaces for Dart/Flutter code
- **Trailing Commas**: Use trailing commas for better formatting and diffs
- **Const Constructors**: Prefer `const` constructors where possible for performance

### Naming Conventions
- **Classes**: PascalCase (e.g., `RecipeService`, `SpringyButton`, `AuthGate`)
- **Files**: snake_case matching class names (e.g., `recipe_service.dart`, `springy_button.dart`)
- **Variables/Functions**: camelCase (e.g., `userId`, `getRecipes`, `signInWithGoogle`)
- **Private Members**: Prefix with underscore (e.g., `_recipesCollection`, `_controller`, `_auth`)
- **Constants**: lowerCamelCase for const values (e.g., `const SpringDescription`)
- **Enums**: PascalCase for type, snake_case for values (e.g., `CuisineType.italian`, `MealType.breakfast`)

### Documentation
- **File Headers**: Generated files include "Generated file. Do not edit." comments
- **Class Documentation**: Use doc comments for public APIs
- **Inline Comments**: Explain complex logic, especially physics simulations and platform-specific code
- **TODO Comments**: Track future improvements inline

## Structural Conventions

### Feature-Based Architecture
- Organize code by feature in `lib/features/` directory
- Each feature contains:
  - `screens/` - UI screens for the feature
  - `services/` - Business logic and API interactions
  - `models/` - Data models (optional, can be in feature or shared)
  - `widgets/` - Feature-specific reusable widgets (optional)

Example structure:
```
lib/features/recipe/
├── models/
│   ├── recipe.dart
│   ├── ingredient.dart
│   └── recipe_enums.dart
├── screens/
│   ├── recipes_screen.dart
│   ├── recipe_detail_screen.dart
│   └── add_recipe_screen.dart
└── services/
    ├── recipe_service.dart
    └── recipe_storage_service.dart
```

### Separation of Concerns
- **Models**: Pure data classes with `toMap()` and `fromMap()` methods
- **Services**: Business logic, Firebase interactions, API calls
- **Screens**: UI composition and user interaction
- **Widgets**: Reusable UI components in `features/common/widgets/`

### File Organization
- One primary class per file
- File name matches the main class name in snake_case
- Related enums and helper classes can share files with main class
- Keep generated files separate (e.g., `GeneratedPluginRegistrant.java`)

## Dart/Flutter Patterns

### Model Classes
```dart
class Recipe {
  final String? id;
  final String name;
  final List<Ingredient> ingredients;
  
  Recipe({
    this.id,
    required this.name,
    required this.ingredients,
    this.userId,
    this.cuisineType = CuisineType.other,  // Default values
  });
  
  // Firestore serialization
  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'ingredients': ingredients.map((i) => i.toMap()).toList(),
    };
  }
  
  // Firestore deserialization
  factory Recipe.fromMap(Map<String, dynamic> map, String id) {
    return Recipe(
      id: id,
      name: map['name'] ?? '',
      ingredients: (map['ingredients'] as List?)
          ?.map((i) => Ingredient.fromMap(i))
          .toList() ?? [],
    );
  }
  
  // Computed properties
  int get totalTime => prepTime + cookTime;
  bool get isVegetarian => dietaryRestrictions.contains(DietaryRestriction.vegetarian);
}
```

### Service Classes
```dart
class RecipeService {
  final CollectionReference _recipesCollection =
      FirebaseFirestore.instance.collection('recipes');
  
  Future<List<Recipe>> getRecipes() async {
    try {
      final QuerySnapshot snapshot = await _recipesCollection.get();
      return snapshot.docs
          .map((doc) => Recipe.fromMap(doc.data() as Map<String, dynamic>, doc.id))
          .toList();
    } catch (e) {
      return [];  // Return empty list on error
    }
  }
  
  Future<void> addRecipe(Recipe recipe) async {
    try {
      await _recipesCollection.add(recipe.toMap());
    } catch (e) {
      debugPrint("Error adding recipe: $e");
      rethrow;  // Rethrow for caller to handle
    }
  }
}
```

### StatefulWidget with Animation
```dart
class SpringyButton extends StatefulWidget {
  const SpringyButton({super.key});
  
  @override
  State<SpringyButton> createState() => _SpringyButtonState();
}

class _SpringyButtonState extends State<SpringyButton>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  
  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      lowerBound: double.negativeInfinity,
      upperBound: double.infinity,
    );
    
    _controller.addListener(() {
      setState(() {
        // Update state
      });
    });
  }
  
  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
```

### Platform-Specific Code
```dart
// Dart - Platform detection
if (kIsWeb) {
  // Web-specific code
  userCredential = await _auth.signInWithPopup(googleProvider);
} else {
  // Mobile-specific code
  userCredential = await _auth.signInWithProvider(googleProvider);
}
```

```kotlin
// Kotlin - Android MainActivity
class MainActivity: FlutterActivity() {
    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        window.setDecorFitsSystemWindows(false)  // Edge-to-edge
    }
}
```

## Firebase Integration Patterns

### Authentication
```dart
class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  
  Stream<User?> get user => _auth.authStateChanges();
  
  Future<User?> signInWithGoogle() async {
    try {
      final GoogleAuthProvider googleProvider = GoogleAuthProvider();
      final UserCredential userCredential = await _auth.signInWithPopup(googleProvider);
      return userCredential.user;
    } catch (e) {
      if (kDebugMode) print('Error: $e');
      rethrow;
    }
  }
}
```

### Firestore Operations
- Use `CollectionReference` for collection-level operations
- Store user ID with user-created content: `userId: FirebaseAuth.instance.currentUser?.uid`
- Handle errors gracefully with try-catch blocks
- Return empty collections on error rather than throwing
- Use `debugPrint()` for error logging

### Data Synchronization
- Models include both `toMap()` for Firestore writes and `fromMap()` for reads
- Pass document ID separately to factory constructors
- Handle null values with `??` operator and default values
- Use type casting: `as Map<String, dynamic>`, `as List?`

## UI/UX Patterns

### Material 3 Design
```dart
ThemeData(
  useMaterial3: true,
  colorScheme: ColorScheme.fromSeed(
    seedColor: const Color(0xFFFFA500),
    brightness: Brightness.light,
  ),
  textTheme: TextTheme(
    displayLarge: const TextStyle(
      fontFamily: 'RobotoFlex',
      fontSize: 57,
      fontWeight: FontWeight.w400,
    ),
  ),
)
```

### Custom Typography
- Use RobotoFlex variable font for all text
- Follow Material 3 type scale (display, headline, title, body, label)
- Apply consistent letter spacing and line height
- Define both light and dark theme text colors

### Edge-to-Edge Display
- Android: `window.setDecorFitsSystemWindows(false)` in MainActivity
- Flutter: `SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge)`
- Transparent system bars in AppBarTheme

### Animation Patterns
- Use `SingleTickerProviderStateMixin` for animations
- Implement `SpringSimulation` for physics-based animations
- Always dispose controllers in `dispose()` method
- Use `late` keyword for controllers initialized in `initState()`

## Error Handling

### Service Layer
```dart
Future<void> addRecipe(Recipe recipe) async {
  try {
    await _recipesCollection.add(recipe.toMap());
  } catch (e) {
    debugPrint("Error adding recipe: $e");
    rethrow;  // Let caller handle
  }
}
```

### Query Operations
```dart
Future<List<Recipe>> getRecipes() async {
  try {
    final QuerySnapshot snapshot = await _recipesCollection.get();
    return snapshot.docs.map(...).toList();
  } catch (e) {
    return [];  // Graceful degradation
  }
}
```

### Debug Logging
- Use `debugPrint()` for Flutter logging
- Use `if (kDebugMode) print()` for conditional debug output
- Console logging in web: `console.log()`, `console.error()`

## Testing Practices

### Test Organization
```
test/
├── models/
│   ├── recipe_test.dart
│   ├── ingredient_test.dart
│   └── meal_plan_test.dart
├── services/
└── widgets/
    └── ingredient_tile_test.dart
```

### Test File Naming
- Match source file name with `_test.dart` suffix
- Place in parallel directory structure under `test/`

## Common Idioms

### Null Safety
```dart
// Null-aware operators
final name = map['name'] ?? '';
final userId = FirebaseAuth.instance.currentUser?.uid;

// Null-aware list operations
(map['ingredients'] as List?)?.map(...).toList() ?? []
```

### Collection Transformations
```dart
// Map with type conversion
ingredients.map((i) => i.toMap()).toList()

// Filter and convert
tags.where((t) => t.isNotEmpty).toSet()

// Enum conversion
CuisineType.values.firstWhere(
  (e) => e.toString() == map['cuisineType'],
  orElse: () => CuisineType.other
)
```

### Async Patterns
```dart
// Async initialization
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const MinimalChefApp());
}

// Try-catch with fallback
try {
  WebRecipeImportService.initialize();
} catch (e) {
  debugPrint('Initialization failed: $e');
}
```

## Platform-Specific Guidelines

### Android
- Use Kotlin for MainActivity
- Extend `FlutterActivity` for main activity
- Package naming: `com.neo_studios.minimal_chef`
- Keep generated files (GeneratedPluginRegistrant.java) unmodified

### iOS
- Use Swift for AppDelegate
- Minimal bridging header: `#import "GeneratedPluginRegistrant.h"`
- Keep ephemeral files (flutter_lldb_helper.py) unmodified

### Web
- Use JavaScript for web-specific utilities (dev-recipes.js)
- Implement Flutter web handlers for JavaScript interop
- Use emoji in console logging for better visibility (🔄, ✅, ❌)

## Best Practices

1. **Immutability**: Use `final` for class fields, prefer immutable data structures
2. **Const Constructors**: Mark constructors `const` when possible
3. **Named Parameters**: Use named parameters for constructors with multiple fields
4. **Factory Constructors**: Use for alternative construction patterns (fromMap, fromMealDb)
5. **Computed Properties**: Use getters for derived values (totalTime, isVegetarian)
6. **Error Recovery**: Return safe defaults rather than crashing
7. **Resource Cleanup**: Always dispose controllers, streams, and listeners
8. **Type Safety**: Use explicit types, avoid `dynamic` where possible
9. **Code Generation**: Don't modify generated files, regenerate instead
10. **Feature Isolation**: Keep features self-contained and loosely coupled
