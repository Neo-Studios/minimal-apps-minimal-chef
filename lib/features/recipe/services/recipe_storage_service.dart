import 'package:minimal_chef/core/services/firestore_service.dart';
import 'package:minimal_chef/data/database_helper.dart';
import 'package:minimal_chef/data/sync_operation.dart';
import 'package:minimal_chef/features/recipe/models/recipe.dart';
import 'package:minimal_chef/features/recipe/models/recipe_enums.dart';

class RecipeStorageService {
  final FirestoreService _firestoreService = FirestoreService();
  final DatabaseHelper _databaseHelper = DatabaseHelper.instance;
  bool _isSyncing = false;

  // Get all recipes with local-first strategy
  Future<List<Recipe>> getAllRecipes() async {
    // First get local recipes
    final localRecipes = await _databaseHelper.getAllRecipes();
    
    // Then try to sync with cloud
    _syncWithCloud();
    
    return localRecipes;
  }

  // Add a new recipe
  Future<void> addRecipe(Recipe recipe) async {
    // First add to local database
    await _databaseHelper.insertRecipe(recipe);
    
    // Then add to cloud
    try {
      await _firestoreService.addRecipe(recipe);
    } catch (e) {
      // Mark for sync later if cloud save fails
      await _markForSync(recipe.id!, 'add');
    }
  }

  // Update an existing recipe
  Future<void> updateRecipe(Recipe recipe) async {
    // First update local database
    await _databaseHelper.updateRecipe(recipe);
    
    // Then update cloud
    try {
      await _firestoreService.updateRecipe(recipe);
    } catch (e) {
      // Mark for sync later if cloud update fails
      await _markForSync(recipe.id!, 'update');
    }
  }

  // Delete a recipe
  Future<void> deleteRecipe(String id) async {
    // First delete from local database
    await _databaseHelper.deleteRecipe(int.parse(id));
    
    // Then delete from cloud
    try {
      await _firestoreService.deleteRecipe(id);
    } catch (e) {
      // Mark for sync later if cloud delete fails
      await _markForSync(id, 'delete');
    }
  }

  // Advanced search with filters
  Future<List<Recipe>> searchRecipes({
    String query = '',
    CuisineType? cuisineType,
    MealType? mealType,
    DifficultyLevel? difficultyLevel,
    Set<DietaryRestriction>? dietaryRestrictions,
    Set<String>? tags,
    int? maxPrepTime,
    int? maxCookTime,
  }) async {
    return _databaseHelper.searchRecipes(
      query,
      cuisineType: cuisineType,
      mealType: mealType,
      difficultyLevel: difficultyLevel,
      dietaryRestrictions: dietaryRestrictions,
      tags: tags,
      maxPrepTime: maxPrepTime,
      maxCookTime: maxCookTime,
    );
  }

  // Sync local database with cloud
  Future<void> _syncWithCloud() async {
    if (_isSyncing) return;
    _isSyncing = true;

    try {
      // Process pending sync operations
      await _processPendingSyncs();

      // Get all cloud recipes
      final cloudRecipes = await _firestoreService.getAllRecipes();
      final localRecipes = await _databaseHelper.getAllRecipes();

      // Create maps for easy lookup
      final cloudMap = {for (var r in cloudRecipes) r.id: r};
      final localMap = {for (var r in localRecipes) r.id: r};

      // Process cloud updates
      for (final recipe in cloudRecipes) {
        if (!localMap.containsKey(recipe.id)) {
          // New recipe in cloud, add to local
          await _databaseHelper.insertRecipe(recipe);
        } else {
          // Update local if cloud version is newer
          // Here you might want to add timestamps for proper versioning
          await _databaseHelper.updateRecipe(recipe);
        }
      }

      // Process local updates
      for (final recipe in localRecipes) {
        if (!cloudMap.containsKey(recipe.id)) {
          // New recipe in local, add to cloud
          try {
            await _firestoreService.addRecipe(recipe);
          } catch (e) {
            // Mark for sync later if cloud save fails
            await _markForSync(recipe.id!, 'add');
          }
        }
      }
    } finally {
      _isSyncing = false;
    }
  }

  Future<void> _markForSync(String recipeId, String operation) async {
    final syncOp = SyncOperation(
      recipeId: recipeId,
      operation: operation,
      createdAt: DateTime.now().millisecondsSinceEpoch,
    );
    await _databaseHelper.addSyncOperation(recipeId, syncOp);
  }

  Future<void> _processPendingSyncs() async {
    final pendingSyncs = await _databaseHelper.getPendingSyncOperations();
    
    for (final sync in pendingSyncs) {
      try {
        switch (sync.operation) {
          case 'add':
            final recipe = await _databaseHelper.getRecipe(int.parse(sync.recipeId));
            if (recipe != null) {
              await _firestoreService.addRecipe(recipe);
            }
            break;
          case 'update':
            final recipe = await _databaseHelper.getRecipe(int.parse(sync.recipeId));
            if (recipe != null) {
              await _firestoreService.updateRecipe(recipe);
            }
            break;
          case 'delete':
            await _firestoreService.deleteRecipe(sync.recipeId);
            break;
        }
        // Remove sync operation after successful sync
        await _databaseHelper.removeSyncOperation(sync.id!);
      } catch (e) {
        // If sync fails, leave the operation in the queue for next attempt
        continue;
      }
    }
  }
}
