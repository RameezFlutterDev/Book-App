import 'package:book_app/features/books/domain/entities/favorite_book_entity.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class FavoritesDbHelper {
  static final FavoritesDbHelper _instance = FavoritesDbHelper._internal();
  factory FavoritesDbHelper() => _instance;
  FavoritesDbHelper._internal();

  static Database? _db;

  Future<Database> get database async {
    if (_db != null) return _db!;
    _db = await _initDb();
    return _db!;
  }

  Future<Database> _initDb() async {
    final path = join(await getDatabasesPath(), 'favorites.db');
    return await openDatabase(
      path,
      version: 1,
      onCreate: _onCreate,
    );
  }

  Future<void> _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE favorites (
        key TEXT PRIMARY KEY,
        title TEXT,
        author TEXT,
        coverId INTEGER
      )
    ''');
  }

  Future<void> insertFavorite(FavoriteBookEntity book) async {
    final db = await database;
    await db.insert(
      'favorites',
      book.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<void> deleteFavorite(String key) async {
    final db = await database;
    await db.delete('favorites', where: 'key = ?', whereArgs: [key]);
  }

  Future<List<FavoriteBookEntity>> getFavorites() async {
    final db = await database;
    final maps = await db.query('favorites');
    return maps.map((e) => FavoriteBookEntity.fromMap(e)).toList();
  }

  Future<bool> isFavorite(String key) async {
    final db = await database;
    final result = await db.query(
      'favorites',
      where: 'key = ?',
      whereArgs: [key],
    );
    return result.isNotEmpty;
  }
}
