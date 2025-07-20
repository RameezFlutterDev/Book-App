class FavoriteBookEntity {
  final String key;
  final String title;
  final String? author;
  final int? coverId;

  FavoriteBookEntity({
    required this.key,
    required this.title,
    this.author,
    this.coverId,
  });

  Map<String, dynamic> toMap() {
    return {
      'key': key,
      'title': title,
      'author': author,
      'coverId': coverId,
    };
  }

  factory FavoriteBookEntity.fromMap(Map<String, dynamic> map) {
    return FavoriteBookEntity(
      key: map['key'],
      title: map['title'],
      author: map['author'],
      coverId: map['coverId'],
    );
  }
}
