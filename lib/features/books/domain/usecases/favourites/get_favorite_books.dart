import 'package:book_app/features/books/domain/entities/book_entity.dart';
import 'package:book_app/features/books/domain/repositories/book_repository.dart';

class GetFavoriteBooks {
  final BookRepository repository;

  GetFavoriteBooks(this.repository);

  Future<List<BookEntity>> call() {
    return repository.getFavoriteBooks();
  }
}
