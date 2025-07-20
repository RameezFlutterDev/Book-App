import 'package:dartz/dartz.dart';
import '../entities/book_entity.dart';
import '../repositories/book_repository.dart';
import '../../../../core/error/failures.dart';

class GetBooksUseCase {
  final BookRepository repository;

  GetBooksUseCase(this.repository);

  Future<Either<Failure, List<BookEntity>>> call({
    required String query,
    required int page,
    required int limit,
  }) async {
    return await repository.searchBooks(
      query: query,
      page: page,
      limit: limit,
    );
  }
}
