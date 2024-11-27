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
  final List<NewsEntity>? news;
  final String? messageFailed;

  const NewsLoaded({
    this.isLoading = false,
    this.isDeleted = false,
    this.news = const [],
    this.messageFailed,
  });

  @override
  List<Object?> get props => [isLoading, isDeleted, news, messageFailed];

  NewsLoaded copyWith({
    bool? isLoading,
    bool? isDeleted,
    List<NewsEntity>? news,
    String? messageFailed,
  }) {
    return NewsLoaded(
      isLoading: isLoading ?? this.isLoading,
      isDeleted: isDeleted ?? this.isDeleted,
      news: news ?? this.news,
      messageFailed: messageFailed ?? this.messageFailed,
    );
  }
}
