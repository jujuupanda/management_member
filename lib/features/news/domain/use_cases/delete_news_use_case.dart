import 'package:equatable/equatable.dart';

import '../../../../core/error/failure.dart';
import 'package:dartz/dartz.dart';

import '../../../../core/shared/entity/blank_entity.dart';
import '../../../../core/shared/use_case/future_use_case.dart';
import '../../data/models/news_model.dart';
import '../repositories/news_repository.dart';

class DeleteNewsUseCase extends FutureUseCase<BlankEntity, DeleteNewsParam> {
  NewsRepository repository;

  DeleteNewsUseCase(this.repository);

  @override
  Future<Either<Failure, BlankEntity>> call(params) async {
    return await repository.deleteNews(params);
  }
}

class DeleteNewsParam extends Equatable {
  final NewsModel news;

  const DeleteNewsParam(this.news);

  @override
  List<Object?> get props => [news];
}
