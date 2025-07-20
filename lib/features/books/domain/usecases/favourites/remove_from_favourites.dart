import 'package:book_app/features/books/domain/repositories/book_repository.dart';

class RemoveFromFavorites {
  final BookRepository repository;

  RemoveFromFavorites(this.repository);

  Future<void> call(String key) {
    return repository.removeFromFavorites(key);
  }
}
