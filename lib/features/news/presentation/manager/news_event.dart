part of 'news_bloc.dart';

sealed class NewsEvent extends Equatable {
  const NewsEvent();
}

final class CreateNews extends NewsEvent {
  final NewsModel news;

  const CreateNews(this.news);

  @override
  List<Object?> get props => [news];
}

final class GetNews extends NewsEvent {
  @override
  List<Object?> get props => [];
}
