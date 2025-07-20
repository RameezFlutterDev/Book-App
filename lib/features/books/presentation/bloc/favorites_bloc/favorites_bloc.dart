import 'package:book_app/features/books/domain/usecases/favourites/add_to_favorites.dart';
import 'package:book_app/features/books/domain/usecases/favourites/get_favorite_books.dart';
import 'package:book_app/features/books/domain/usecases/favourites/is_favourite.dart';
import 'package:book_app/features/books/domain/usecases/favourites/remove_from_favourites.dart';
import 'package:book_app/features/books/presentation/bloc/favorites_bloc/favorites_event.dart';
import 'package:book_app/features/books/presentation/bloc/favorites_bloc/favorites_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FavoritesBloc extends Bloc<FavoritesEvent, FavoritesState> {
  final AddToFavorites addToFavorites;
  final RemoveFromFavorites removeFromFavorites;
  final GetFavoriteBooks getFavoriteBooks;
  final IsFavorite isFavorite;

  FavoritesBloc({
    required this.addToFavorites,
    required this.removeFromFavorites,
    required this.getFavoriteBooks,
    required this.isFavorite,
  }) : super(FavoritesInitial()) {
    on<LoadFavorites>(_onLoadFavorites);
    on<AddFavorite>(_onAddFavorite);
    on<RemoveFavorite>(_onRemoveFavorite);
    on<CheckFavorite>(_onCheckFavorite);
  }

  Future<void> _onLoadFavorites(LoadFavorites event, Emitter emit) async {
    try {
      final favs = await getFavoriteBooks();
      emit(FavoritesLoaded(favs));
    } catch (e) {
      emit(FavoritesError(e.toString()));
    }
  }

  Future<void> _onAddFavorite(AddFavorite event, Emitter emit) async {
    try {
      await addToFavorites(event.book);

      // Check and emit updated status directly
      final fav = await isFavorite(event.book.key);
      emit(FavoriteStatus(fav));
    } catch (e) {
      emit(FavoritesError("Failed to add favorite: ${e.toString()}"));
    }
  }

  Future<void> _onRemoveFavorite(RemoveFavorite event, Emitter emit) async {
    try {
      await removeFromFavorites(event.key);

      // Check and emit updated status directly
      final fav = await isFavorite(event.key);
      emit(FavoriteStatus(fav));
    } catch (e) {
      emit(FavoritesError("Failed to remove favorite: ${e.toString()}"));
    }
  }

  Future<void> _onCheckFavorite(CheckFavorite event, Emitter emit) async {
    try {
      final fav = await isFavorite(event.key);
      emit(FavoriteStatus(fav));
    } catch (e) {
      emit(FavoritesError("Failed to check favorite: ${e.toString()}"));
    }
  }
}
