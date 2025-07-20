import 'package:book_app/features/books/domain/entities/book_entity.dart';
import 'package:equatable/equatable.dart';

abstract class FavoritesEvent extends Equatable {
  const FavoritesEvent();
  @override
  List<Object?> get props => [];
}

class LoadFavorites extends FavoritesEvent {}

class AddFavorite extends FavoritesEvent {
  final BookEntity book;
  const AddFavorite(this.book);
  @override
  List<Object?> get props => [book];
}

class RemoveFavorite extends FavoritesEvent {
  final String key;
  const RemoveFavorite(this.key);
  @override
  List<Object?> get props => [key];
}

class CheckFavorite extends FavoritesEvent {
  final String key;
  const CheckFavorite(this.key);
  @override
  List<Object?> get props => [key];
}
