import 'package:book_app/features/books/data/model/search_result_model.dart';
import 'package:retrofit/retrofit.dart';
import 'package:dio/dio.dart';

part 'book_api_service.g.dart';

@RestApi(baseUrl: "https://openlibrary.org/")
abstract class BookApiService {
  factory BookApiService(Dio dio, {String baseUrl}) = _BookApiService;

  @GET("search.json")
  Future<HttpResponse<SearchResultModel>> searchBooks(
    @Query("q") String query,
    @Query("page") int page,
    @Query("limit") int limit,
  );
}
