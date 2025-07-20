import 'package:book_app/core/error/exceptions.dart';
import 'package:book_app/features/books/data/datasources/book_api_service.dart';
import 'package:book_app/features/books/data/model/book_model.dart';
import 'package:dio/dio.dart';

import '../../domain/entities/book_entity.dart';

abstract class BookRemoteDataSource {
  Future<List<BookEntity>> searchBooks({
    required String query,
    required int page,
    required int limit,
  });
}

class BookRemoteDataSourceImpl implements BookRemoteDataSource {
  final BookApiService apiService;

  BookRemoteDataSourceImpl(this.apiService);

  @override
  Future<List<BookEntity>> searchBooks({
    required String query,
    required int page,
    required int limit,
  }) async {
    try {
      final response = await apiService.searchBooks(query, page, limit);

      final List<BookModel> models = response.data.docs;

      return models.map((e) => e.toEntity()).toList();
    } on DioException catch (e) {
      // Forward error to the repository
      throw ServerException(e.message ?? 'Unknown error occurred');
    }
  }
}
