import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

import '../../../../core/error/failure.dart';
import '../../../../core/shared/entity/blank_entity.dart';
import '../../../../core/shared/use_case/future_use_case.dart';
import '../../data/models/news_model.dart';
import '../repositories/news_repository.dart';

class CreateNewsUseCase extends FutureUseCase<BlankEntity, CreateNewsParam> {
  NewsRepository repository;

  CreateNewsUseCase(this.repository);

  @override
  Future<Either<Failure, BlankEntity>> call(CreateNewsParam params) async {
    return await repository.createNews(params);
  }
}

class CreateNewsParam extends Equatable {
  final NewsModel news;

  const CreateNewsParam(this.news);

  @override
  List<Object?> get props => [news];
}
