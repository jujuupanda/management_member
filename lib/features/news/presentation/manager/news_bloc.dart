import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/error/failure.dart';
import '../../data/models/news_model.dart';
import '../../domain/entities/news_entity.dart';
import '../../domain/use_cases/create_news_use_case.dart';
import '../../domain/use_cases/get_news_use_case.dart';

part 'news_event.dart';

part 'news_state.dart';

class NewsBloc extends Bloc<NewsEvent, NewsState> {
  CreateNewsUseCase createNewsUseCase;
  GetNewsUseCase getNewsUseCase;

  NewsBloc({
    required this.createNewsUseCase,
    required this.getNewsUseCase,
  }) : super(NewsInitial()) {
    on<NewsEvent>((event, emit) {});
    on<CreateNews>(createNews);
    on<GetNews>(getNews);
  }

  createNews(CreateNews event, Emitter<NewsState> emit) async {
    final currentState = state is NewsLoaded
        ? state as NewsLoaded
        : const NewsLoaded().copyWith();
    emit(currentState.copyWith(isLoading: true));

    final toCreate = NewsModel(
      id: event.news.id,
      title: event.news.title,
      content: event.news.content,
      image: event.news.image,
      author: event.news.author,
      publishedAt: event.news.publishedAt,
      category: event.news.category,
    );
    try {
      final newsCreated =
          await createNewsUseCase.call(CreateNewsParam(toCreate));
      return newsCreated.fold(
        (l) {
          if (l is ServerFailure) {
            emit(currentState.copyWith(isLoading: false));
          }
        },
        (r) {
          emit(currentState.copyWith(isLoading: false));
        },
      );
    } catch (e) {
      emit(currentState.copyWith(isLoading: false));
    }
  }

  getNews(GetNews event, Emitter<NewsState> emit) async {
    final currentState = state is NewsLoaded
        ? state as NewsLoaded
        : const NewsLoaded().copyWith();
    emit(currentState.copyWith(isLoading: true));

    final getNewsParam = GetNewsParam();

    final gotNews = getNewsUseCase.call(getNewsParam);
    await gotNews.forEach(
      (element) => element.fold(
        (l) {
          if (l is ServerFailure) {
            emit(currentState.copyWith(isLoading: false));
          }
        },
        (r) {
          emit(currentState.copyWith(isLoading: false, news: r));
        },
      ),
    );
  }
}
