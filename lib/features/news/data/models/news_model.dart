import '../../domain/entities/news_entity.dart';

class NewsModel extends NewsEntity {
  NewsModel({
    required super.id,
    required super.title,
    required super.content,
    required super.image,
    required super.author,
    required super.publishedAt,
    required super.category,
  });

  factory NewsModel.fromJson(Map<String, dynamic> json) {
    return NewsModel(
      id: json["id"] ?? "",
      title: json["title"] ?? "",
      content: json["content"] ?? "",
      image: (json["image"] is List) ? List<String>.from(json["image"]) : [],
      author: json["author"] ?? "",
      publishedAt: json["published_at"] ?? DateTime.now().toString(),
      category: json["category"] ?? "",
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "title": title,
      "content": content,
      "image": image,
      "author": author,
      "published_at": publishedAt,
      "category": category,
    };
  }

  NewsEntity toEntity() {
    return NewsEntity(
      id: id,
      title: title,
      content: content,
      image: image,
      author: author,
      publishedAt: publishedAt,
      category: category,
    );
  }

  static NewsModel fromEntity(NewsEntity news) {
    return NewsModel(
      id: news.id,
      title: news.title,
      content: news.content,
      image: news.image,
      author: news.author,
      publishedAt: news.publishedAt,
      category: news.category,
    );
  }

  NewsModel copyWith(Map<String, dynamic> updates) {
    return NewsModel(
      id: updates["id"] ?? id,
      title: updates["title"] ?? title,
      content: updates["content"] ?? content,
      image: updates["image"] ?? image,
      author: updates["author"] ?? author,
      publishedAt: updates["published_at"] ?? publishedAt,
      category: updates["category"] ?? category,
    );
  }
}
