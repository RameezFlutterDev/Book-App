import 'package:equatable/equatable.dart';

abstract class BooksEvent extends Equatable {
  const BooksEvent();

  @override
  List<Object> get props => [];
}

class SearchBooks extends BooksEvent {
  final String query;
  final int page;
  final int limit;

  const SearchBooks(
      {required this.query, required this.page, required this.limit});

  @override
  List<Object> get props => [query, page, limit];
}

class LoadMoreBooks extends BooksEvent {
  final String query;
  final int nextPage;
  final int limit;

  const LoadMoreBooks(
      {required this.query, required this.nextPage, required this.limit});

  @override
  List<Object> get props => [query, nextPage, limit];
}
