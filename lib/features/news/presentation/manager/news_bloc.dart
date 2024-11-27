import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/error/failure.dart';
import '../../data/models/news_model.dart';
import '../../domain/entities/news_entity.dart';
import '../../domain/use_cases/create_news_use_case.dart';
import '../../domain/use_cases/delete_news_use_case.dart';
import '../../domain/use_cases/edit_news_use_case.dart';
import '../../domain/use_cases/get_news_use_case.dart';

part 'news_event.dart';

part 'news_state.dart';

class NewsBloc extends Bloc<NewsEvent, NewsState> {
  CreateNewsUseCase createNewsUseCase;
  GetNewsUseCase getNewsUseCase;
  EditNewsUseCase editNewsUseCase;
  DeleteNewsUseCase deleteNewsUseCase;

  NewsBloc({
    required this.createNewsUseCase,
    required this.getNewsUseCase,
    required this.editNewsUseCase,
    required this.deleteNewsUseCase,
  }) : super(NewsInitial()) {
    on<NewsEvent>((event, emit) {});
    on<CreateNews>(createNews);
    on<GetNews>(getNews);
    on<EditNews>(editNews);
    on<DeleteNews>(deleteNews);
  }

  createNews(CreateNews event, Emitter<NewsState> emit) async {
    final currentState = state is NewsLoaded
        ? state as NewsLoaded
        : const NewsLoaded().copyWith();
    emit(currentState.copyWith(isLoading: true, isCreated: false));

    final toCreate = NewsModel(
      id: event.news.id,
      title: event.news.title,
      content: event.news.content,
      image: event.news.image,
      author: event.news.author,
      publishedAt: event.news.publishedAt,
      category: event.news.category,
      archived: event.news.archived,
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
          emit(currentState.copyWith(isLoading: false, isCreated: true));
          add(GetNews());
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

  editNews(EditNews event, Emitter<NewsState> emit) async {
    final currentState = state is NewsLoaded
        ? state as NewsLoaded
        : const NewsLoaded().copyWith();

    emit(currentState.copyWith(isLoading: true));
    final fromEntity = NewsModel.fromEntity(event.news);
    final toUpdate = EditNewsParam(fromEntity.copyWith(event.object));
    final newsUpdated = await editNewsUseCase.call(toUpdate);
    return newsUpdated.fold(
      (l) {
        if (l is ServerFailure) {
          emit(currentState.copyWith(isLoading: false));
        }
      },
      (r) {
        emit(currentState.copyWith(isLoading: false));
        add(GetNews());
      },
    );
  }

  deleteNews(DeleteNews event, Emitter<NewsState> emit) async {
    final currentState = state is NewsLoaded
        ? state as NewsLoaded
        : const NewsLoaded().copyWith();

    emit(currentState.copyWith(isLoading: true));
    final fromEntity = NewsModel.fromEntity(event.news);
    final toDelete =
        DeleteNewsParam(fromEntity.copyWith({"id": fromEntity.id}));
    final newsDeleted = await deleteNewsUseCase.call(toDelete);
    return newsDeleted.fold(
      (l) {
        if (l is ServerFailure) {
          emit(currentState.copyWith(isLoading: false));
        }
      },
      (r) {
        emit(currentState.copyWith(isLoading: false, isDeleted: true));
        add(GetNews());
      },
    );
  }
}
