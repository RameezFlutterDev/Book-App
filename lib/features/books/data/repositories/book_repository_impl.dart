import 'package:book_app/features/books/data/datasources/book_local_data_sources.dart';
import 'package:book_app/features/books/domain/entities/favorite_book_entity.dart';
import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/error/exceptions.dart';
import '../../domain/entities/book_entity.dart';
import '../../domain/repositories/book_repository.dart';
import '../datasources/book_remote_data_source.dart';

class BookRepositoryImpl implements BookRepository {
  final BookRemoteDataSource remoteDataSource;
  final BookLocalDataSource localDataSource;

  BookRepositoryImpl({
    required this.remoteDataSource,
    required this.localDataSource,
  });

  @override
  Future<Either<Failure, List<BookEntity>>> searchBooks({
    required String query,
    required int page,
    required int limit,
  }) async {
    try {
      final books = await remoteDataSource.searchBooks(
        query: query,
        page: page,
        limit: limit,
      );
      return Right(books);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message));
    } catch (e) {
      return Left(GeneralFailure(e.toString()));
    }
  }

  @override
  Future<void> addToFavorites(BookEntity book) {
    final favorite = FavoriteBookEntity(
      key: book.key,
      title: book.title,
      author: book.authorName?.join(', '),
      coverId: book.coverId,
    );
    return localDataSource.addFavorite(favorite);
  }

  @override
  Future<void> removeFromFavorites(String key) {
    return localDataSource.removeFavorite(key);
  }

  @override
  Future<List<BookEntity>> getFavoriteBooks() async {
    final favorites = await localDataSource.getFavorites();
    return favorites
        .map((e) => BookEntity(
              key: e.key,
              title: e.title,
              authorName: e.author?.split(', '),
              coverId: e.coverId,
              firstPublishYear: null,
              editionCount: null,
              languages: null,
            ))
        .toList();
  }

  @override
  Future<bool> isFavorite(String key) {
    return localDataSource.isFavorite(key);
  }
}
