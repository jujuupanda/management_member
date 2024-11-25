import 'package:equatable/equatable.dart';

import '../../../../core/error/failure.dart';
import 'package:dartz/dartz.dart';

import '../../../../core/shared/use_case/stream_use_case.dart';
import '../entities/news_entity.dart';
import '../repositories/news_repository.dart';

class GetNewsUseCase extends StreamUseCase<List<NewsEntity>, GetNewsParam> {
  NewsRepository repository;

  GetNewsUseCase(this.repository);

  @override
  Stream<Either<Failure, List<NewsEntity>>> call(params) {
    return repository.getNews(params);
  }
}

class GetNewsParam extends Equatable {
  @override
  List<Object?> get props => [];
}
