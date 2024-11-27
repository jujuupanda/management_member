import 'package:equatable/equatable.dart';

import '../../../../core/error/failure.dart';
import 'package:dartz/dartz.dart';

import '../../../../core/shared/entity/blank_entity.dart';
import '../../../../core/shared/use_case/future_use_case.dart';
import '../../data/models/news_model.dart';
import '../repositories/news_repository.dart';

class EditNewsUseCase extends FutureUseCase<BlankEntity, EditNewsParam> {
  NewsRepository repository;

  EditNewsUseCase(this.repository);

  @override
  Future<Either<Failure, BlankEntity>> call(params) async {
    return await repository.editNews(params);
  }
}

class EditNewsParam extends Equatable {
  final NewsModel news;

  const EditNewsParam(this.news);

  @override
  List<Object?> get props => [news];
}
