import 'package:book_app/features/books/domain/repositories/book_repository.dart';

class IsFavorite {
  final BookRepository repository;

  IsFavorite(this.repository);

  Future<bool> call(String key) {
    return repository.isFavorite(key);
  }
}
