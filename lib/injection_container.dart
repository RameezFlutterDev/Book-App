import 'package:book_app/features/books/data/datasources/book_local_data_sources.dart';
import 'package:book_app/features/books/data/datasources/favourites_db_helper.dart';
import 'package:book_app/features/books/domain/usecases/favourites/add_to_favorites.dart';
import 'package:book_app/features/books/domain/usecases/favourites/get_favorite_books.dart';
import 'package:book_app/features/books/domain/usecases/favourites/is_favourite.dart';
import 'package:book_app/features/books/domain/usecases/favourites/remove_from_favourites.dart';
import 'package:book_app/features/books/presentation/bloc/books_bloc/books_bloc.dart';
import 'package:book_app/features/books/presentation/bloc/favorites_bloc/favorites_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:dio/dio.dart';
import 'features/books/data/datasources/book_api_service.dart';
import 'features/books/data/datasources/book_remote_data_source.dart';
import 'features/books/data/repositories/book_repository_impl.dart';
import 'features/books/domain/repositories/book_repository.dart';
import 'features/books/domain/usecases/get_books_usecase.dart';

final sl = GetIt.instance;

Future<void> init() async {
  // BLoC
  sl.registerFactory(() => BooksBloc(sl()));
  sl.registerFactory(() => FavoritesBloc(
        addToFavorites: sl(),
        removeFromFavorites: sl(),
        getFavoriteBooks: sl(),
        isFavorite: sl(),
      ));

  // Use Cases
  sl.registerLazySingleton(() => GetBooksUseCase(sl()));

  sl.registerLazySingleton(() => FavoritesDbHelper());
  sl.registerLazySingleton<BookLocalDataSource>(
      () => BookLocalDataSourceImpl(sl()));

  // Repository
  sl.registerLazySingleton<BookRepository>(
    () => BookRepositoryImpl(
      remoteDataSource: sl(),
      localDataSource: sl(),
    ),
  );

  // Data Sources
  sl.registerLazySingleton<BookRemoteDataSource>(
    () => BookRemoteDataSourceImpl(sl()),
  );

  // Retrofit API Client
  sl.registerLazySingleton<BookApiService>(
    () => BookApiService(sl()),
  );

  // Dio
  sl.registerLazySingleton(() => Dio());
  sl.registerLazySingleton(() => AddToFavorites(sl()));
  sl.registerLazySingleton(() => RemoveFromFavorites(sl()));
  sl.registerLazySingleton(() => GetFavoriteBooks(sl()));
  sl.registerLazySingleton(() => IsFavorite(sl()));
}
