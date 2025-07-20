import 'package:book_app/features/books/data/datasources/favourites_db_helper.dart';
import 'package:book_app/features/books/domain/entities/favorite_book_entity.dart';

abstract class BookLocalDataSource {
  Future<void> addFavorite(FavoriteBookEntity book);
  Future<void> removeFavorite(String key);
  Future<List<FavoriteBookEntity>> getFavorites();
  Future<bool> isFavorite(String key);
}

class BookLocalDataSourceImpl implements BookLocalDataSource {
  final FavoritesDbHelper dbHelper;

  BookLocalDataSourceImpl(this.dbHelper);

  @override
  Future<void> addFavorite(FavoriteBookEntity book) {
    return dbHelper.insertFavorite(book);
  }

  @override
  Future<void> removeFavorite(String key) {
    return dbHelper.deleteFavorite(key);
  }

  @override
  Future<List<FavoriteBookEntity>> getFavorites() {
    return dbHelper.getFavorites();
  }

  @override
  Future<bool> isFavorite(String key) {
    return dbHelper.isFavorite(key);
  }
}
