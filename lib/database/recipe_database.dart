import 'dart:async';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import '../models/recipe_model.dart';

class RecipeDatabase {
  static final RecipeDatabase instance = RecipeDatabase._init();
  static Database? _database;

  RecipeDatabase._init();

  Future<Database> get database async {
    if (_database != null) return _database!;

    _database = await _initDB('recipes.db');
    return _database!;
  }

  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);

    return await openDatabase(path, version: 1, onCreate: _createDB);
  }

  Future _createDB(Database db, int version) async {
    await db.execute('''
    CREATE TABLE recipes (
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      title TEXT NOT NULL,
      steps TEXT NOT NULL,
      imageUrl TEXT
    )
    ''');
  }

  Future<void> insertRecipe(Recipe recipe) async {
    final db = await instance.database;
    await db.insert('recipes', recipe.toMap());
  }

  Future<List<Recipe>> fetchRecipes() async {
    final db = await instance.database;

    final result = await db.query('recipes');

    return result.map((map) => Recipe.fromMap(map)).toList();
  }

  Future close() async {
    final db = await instance.database;
    db.close();
  }
}
