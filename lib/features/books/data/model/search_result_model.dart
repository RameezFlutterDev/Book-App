import 'package:json_annotation/json_annotation.dart';
import 'book_model.dart';

part 'search_result_model.g.dart';

@JsonSerializable()
class SearchResultModel {
  final int numFound;
  final List<BookModel> docs;

  SearchResultModel({
    required this.numFound,
    required this.docs,
  });

  factory SearchResultModel.fromJson(Map<String, dynamic> json) =>
      _$SearchResultModelFromJson(json);

  Map<String, dynamic> toJson() => _$SearchResultModelToJson(this);
}
