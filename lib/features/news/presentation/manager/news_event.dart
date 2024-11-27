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

final class EditNews extends NewsEvent {
  final NewsEntity news;
  final Map<String, dynamic> object;

  const EditNews(this.news, this.object);

  @override
  List<Object?> get props => [news, object];
}

final class DeleteNews extends NewsEvent {
  final NewsEntity news;

  const DeleteNews(this.news);

  @override
  List<Object?> get props => [news];
}
