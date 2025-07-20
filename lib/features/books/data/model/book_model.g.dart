// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'book_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BookModel _$BookModelFromJson(Map<String, dynamic> json) => BookModel(
      title: json['title'] as String,
      authorName: (json['author_name'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      coverId: (json['cover_i'] as num?)?.toInt(),
      firstPublishYear: (json['first_publish_year'] as num?)?.toInt(),
      editionCount: (json['edition_count'] as num?)?.toInt(),
      language: (json['language'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      key: json['key'] as String,
    );

Map<String, dynamic> _$BookModelToJson(BookModel instance) => <String, dynamic>{
      'title': instance.title,
      'author_name': instance.authorName,
      'cover_i': instance.coverId,
      'first_publish_year': instance.firstPublishYear,
      'edition_count': instance.editionCount,
      'language': instance.language,
      'key': instance.key,
    };
