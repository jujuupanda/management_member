class NewsEntity {
  final String id;
  final String title;
  final String content;
  final List<String> image;
  final String author;
  final String publishedAt;
  final String category;
  final bool archived;

  const NewsEntity({
    required this.id,
    required this.title,
    required this.content,
    required this.image,
    required this.author,
    required this.publishedAt,
    required this.category,
    required this.archived,
  });
}
