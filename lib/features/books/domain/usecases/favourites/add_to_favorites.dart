import 'package:book_app/features/books/domain/entities/book_entity.dart';
import 'package:book_app/features/books/domain/repositories/book_repository.dart';

class AddToFavorites {
  final BookRepository repository;

  AddToFavorites(this.repository);

  Future<void> call(BookEntity book) {
    return repository.addToFavorites(book);
  }
}
