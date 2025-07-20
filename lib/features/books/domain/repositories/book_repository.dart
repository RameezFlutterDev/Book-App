import 'package:book_app/core/error/failures.dart';
import 'package:book_app/features/books/domain/entities/book_entity.dart';
import 'package:dartz/dartz.dart';

abstract class BookRepository {
  Future<Either<Failure, List<BookEntity>>> searchBooks({
    required String query,
    required int page,
    required int limit,
  });

  Future<void> addToFavorites(BookEntity book);
  Future<void> removeFromFavorites(String key);
  Future<List<BookEntity>> getFavoriteBooks();
  Future<bool> isFavorite(String key);
}
