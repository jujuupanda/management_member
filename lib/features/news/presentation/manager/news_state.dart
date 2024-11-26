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
  final List<NewsEntity>? news;
  final String? messageFailed;

  const NewsLoaded({
    this.isLoading = false,
    this.news = const [],
    this.messageFailed,
  });

  @override
  List<Object?> get props => [isLoading, news, messageFailed];

  NewsLoaded copyWith({
    bool? isLoading,
    List<NewsEntity>? news,
    String? messageFailed,
  }) {
    return NewsLoaded(
      isLoading: isLoading ?? this.isLoading,
      news: news ?? this.news,
      messageFailed: messageFailed ?? this.messageFailed,
    );
  }
}
