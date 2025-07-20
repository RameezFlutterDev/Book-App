import 'package:json_annotation/json_annotation.dart';
import '../../domain/entities/book_entity.dart';

part 'book_model.g.dart';

@JsonSerializable()
class BookModel {
  final String title;

  @JsonKey(name: 'author_name')
  final List<String>? authorName;

  @JsonKey(name: 'cover_i')
  final int? coverId;

  @JsonKey(name: 'first_publish_year')
  final int? firstPublishYear;

  @JsonKey(name: 'edition_count')
  final int? editionCount;

  final List<String>? language;

  final String key;

  BookModel({
    required this.title,
    this.authorName,
    this.coverId,
    this.firstPublishYear,
    this.editionCount,
    this.language,
    required this.key,
  });

  factory BookModel.fromJson(Map<String, dynamic> json) =>
      _$BookModelFromJson(json);

  Map<String, dynamic> toJson() => _$BookModelToJson(this);

  BookEntity toEntity() => BookEntity(
        title: title,
        authorName: authorName,
        coverId: coverId,
        firstPublishYear: firstPublishYear,
        editionCount: editionCount,
        languages: language,
        key: key,
      );
}
