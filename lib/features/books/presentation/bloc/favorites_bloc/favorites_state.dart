import 'package:book_app/features/books/domain/entities/book_entity.dart';
import 'package:equatable/equatable.dart';

abstract class FavoritesState extends Equatable {
  const FavoritesState();
  @override
  List<Object?> get props => [];
}

class FavoritesInitial extends FavoritesState {}

class FavoritesLoaded extends FavoritesState {
  final List<BookEntity> favorites;
  const FavoritesLoaded(this.favorites);
  @override
  List<Object?> get props => [favorites];
}

class FavoriteStatus extends FavoritesState {
  final bool isFavorite;
  const FavoriteStatus(this.isFavorite);
  @override
  List<Object?> get props => [isFavorite];
}

class FavoritesError extends FavoritesState {
  final String message;
  const FavoritesError(this.message);
  @override
  List<Object?> get props => [message];
}
