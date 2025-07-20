import 'package:equatable/equatable.dart';
import '../../../domain/entities/book_entity.dart';

abstract class BooksState extends Equatable {
  const BooksState();

  @override
  List<Object?> get props => [];
}

class BooksInitial extends BooksState {}

class BooksLoading extends BooksState {}

class BooksLoaded extends BooksState {
  final List<BookEntity> books;
  final int currentPage;
  final bool hasMore;

  const BooksLoaded({
    required this.books,
    required this.currentPage,
    required this.hasMore,
  });

  @override
  List<Object?> get props => [books, currentPage, hasMore];
}

class BooksError extends BooksState {
  final String message;

  const BooksError(this.message);

  @override
  List<Object?> get props => [message];
}
