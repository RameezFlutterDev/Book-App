class BookEntity {
  final String title;
  final List<String>? authorName;
  final int? coverId;
  final int? firstPublishYear;
  final int? editionCount;
  final List<String>? languages;
  final String key;

  BookEntity({
    required this.title,
    this.authorName,
    this.coverId,
    this.firstPublishYear,
    this.editionCount,
    this.languages,
    required this.key,
  });
}
