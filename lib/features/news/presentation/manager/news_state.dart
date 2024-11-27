part of 'news_bloc.dart';

sealed class NewsState extends Equatable {
  const NewsState();
}

final class NewsInitial extends NewsState {
  @override
  List<Object> get props => [];
}

final class NewsLoaded extends NewsState {
  final bool? isLoading;
  final bool? isDeleted;
  final bool? isCreated;
  final List<NewsEntity>? news;
  final String? messageFailed;

  const NewsLoaded({
    this.isLoading = false,
    this.isDeleted = false,
    this.isCreated = false,
    this.news = const [],
    this.messageFailed,
  });

  @override
  List<Object?> get props =>
      [isLoading, isDeleted, isCreated, news, messageFailed];

  NewsLoaded copyWith({
    bool? isLoading,
    bool? isDeleted,
    bool? isCreated,
    List<NewsEntity>? news,
    String? messageFailed,
  }) {
    return NewsLoaded(
      isLoading: isLoading ?? this.isLoading,
      isDeleted: isDeleted ?? this.isDeleted,
      isCreated: isCreated ?? this.isCreated,
      news: news ?? this.news,
      messageFailed: messageFailed ?? this.messageFailed,
    );
  }
}
