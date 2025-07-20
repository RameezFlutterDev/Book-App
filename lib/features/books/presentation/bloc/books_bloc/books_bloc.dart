import 'package:flutter_bloc/flutter_bloc.dart';
import 'books_event.dart';
import 'books_state.dart';
import '../../../domain/usecases/get_books_usecase.dart';
import '../../../domain/entities/book_entity.dart';

class BooksBloc extends Bloc<BooksEvent, BooksState> {
  final GetBooksUseCase getBooksUseCase;

  List<BookEntity> _allBooks = [];
  int _currentPage = 1;

  BooksBloc(this.getBooksUseCase) : super(BooksInitial()) {
    on<SearchBooks>(_onSearchBooks);
    on<LoadMoreBooks>(_onLoadMoreBooks);
  }

  Future<void> _onSearchBooks(
      SearchBooks event, Emitter<BooksState> emit) async {
    emit(BooksLoading());

    final result = await getBooksUseCase(
      query: event.query,
      page: event.page,
      limit: event.limit,
    );

    result.fold(
      (failure) => emit(BooksError(failure.message)),
      (books) {
        _allBooks = books;
        _currentPage = event.page;
        emit(BooksLoaded(
            books: books,
            currentPage: _currentPage,
            hasMore: books.length == event.limit));
      },
    );
  }

  Future<void> _onLoadMoreBooks(
      LoadMoreBooks event, Emitter<BooksState> emit) async {
    final result = await getBooksUseCase(
      query: event.query,
      page: event.nextPage,
      limit: event.limit,
    );

    result.fold(
      (failure) => emit(BooksError(failure.message)),
      (books) {
        _allBooks.addAll(books);
        _currentPage = event.nextPage;
        emit(BooksLoaded(
            books: _allBooks,
            currentPage: _currentPage,
            hasMore: books.length == event.limit));
      },
    );
  }
}
